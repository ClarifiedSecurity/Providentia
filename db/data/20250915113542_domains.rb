# frozen_string_literal: true

class Domains < ActiveRecord::Migration[8.0]
  def up
    Exercise.includes(:networks, :domains).find_each do |exercise|
      process_exercise(exercise)
    end
  end

  def down
    DomainBinding.delete_all
    Domain.delete_all
  end

  private
    def process_exercise(exercise)
      log "Processing #{exercise.name}"

      if exercise.root_domain.present?
        process_root_domain(exercise)
      end

      process_ignored_root_domains(exercise)
      process_fallback_domains(exercise) if exercise.domains.empty?

      log "Processing #{exercise.name} is done\n"
    end

    def process_root_domain(exercise)
      log "Root domain is #{exercise.root_domain}, creating domain + bindings for it"
      domain = find_or_create_domain(exercise, exercise.root_domain)
      networks = exercise.networks.where(ignore_root_domain: false)
      create_domain_bindings_for_networks(networks, domain)
    end

    def process_ignored_root_domains(exercise)
      log 'Enumerating networks with ignore_root_domain = true, creating domains + bindings if found'

      networks_with_domains = exercise.networks.where(ignore_root_domain: true).reject { |network| network.domain.blank? }
      networks_by_upper_domain = group_networks_by_domain_hierarchy(networks_with_domains)

      networks_by_upper_domain.each do |upper_domain, networks|
        domain_name = extract_upper_domain(upper_domain)
        domain = find_or_create_domain(exercise, domain_name)
        create_domain_bindings_for_networks(networks, domain, strip_suffix: domain_name)
      end
    end

    def process_fallback_domains(exercise)
      log 'No root domain or networks with ignore_root_domain = true found, creating domains from networks'

      exercise.networks.each do |network|
        next unless network.domain.present?
        domain_name = network.domain.match?(/}}/) ? extract_upper_domain(network.domain) : network.domain
        domain = find_or_create_domain(exercise, domain_name)
        name = network.domain.match?(/}}/) ? calculate_binding_name(network.domain, domain_name) : ''
        create_domain_binding(network, domain, name)
      end
    end

    def group_networks_by_domain_hierarchy(networks)
      networks.sort_by { |network| network.domain.length }.each_with_object({}) do |network, result|
        current_domain = network.domain
        result[current_domain] ||= []
        result[current_domain] << network
      end
    end

    def create_domain_bindings_for_networks(networks, domain, strip_suffix: false)
      networks.group_by { |network| render_liquid_template(network.domain) }.each do |_, grouped_networks|
        name = calculate_binding_name(grouped_networks.first.domain, strip_suffix)
        grouped_networks.each { |network| create_domain_binding(network, domain, name) }
      end
    end

    def calculate_binding_name(domain, strip_suffix)
      strip_suffix ? domain.gsub(/\.?#{Regexp.escape(strip_suffix)}$/, '') : domain
    end

    def extract_upper_domain(domain)
      if domain.match?(/}}/)
        _, _, upper_domain = domain.rpartition(/}}?/)
        upper_domain.gsub(/^\W*/, '') # remove all non-character trash at the beginning
      else
        domain
      end
    end

    def render_liquid_template(domain_template)
      template_vars = { 'team_nr' => 1, 'team_nr_str' => '1' }
      Liquid::Template.parse(domain_template).render(template_vars)
    rescue Liquid::Error => e
      log "Warning: Failed to parse Liquid template '#{domain_template}': #{e.message}"
      domain_template
    end

    def find_or_create_domain(exercise, name)
      exercise.domains.where(name: name&.strip&.downcase).first_or_create!
    rescue ActiveRecord::RecordInvalid => e
      log "Error creating domain '#{name}': #{e.message}"
      raise
    end

    def create_domain_binding(network, domain, name)
      network.domain_bindings.where(domain: domain, name: name&.strip&.downcase).first_or_create!
    rescue ActiveRecord::RecordInvalid => e
      log "Error creating domain binding for network '#{network.name}': #{e.message}"
      raise
    end

    def log(message)
      puts message
    end
end
