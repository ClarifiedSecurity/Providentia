# frozen_string_literal: true

class Domains < ActiveRecord::Migration[8.0]
  def up
    # Use find_each for better memory management with large datasets
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
      puts "Processing #{exercise.name}"

      process_root_domain(exercise) if exercise.root_domain.present?
      process_ignored_root_domains(exercise)
      process_fallback_domains(exercise) if exercise.domains.empty?

      puts "Processing #{exercise.name} is done\n"
    end

    def process_root_domain(exercise)
      puts "Root domain is #{exercise.root_domain}, creating domain + bindings for it"
      domain = find_or_create_domain(exercise, exercise.root_domain)

      networks = exercise.networks.where(ignore_root_domain: false)
      create_domain_bindings_for_networks(networks, domain)
    end

    def process_ignored_root_domains(exercise)
      puts 'Enumerating networks with ignore_root_domain = true, creating domains + bindings if found'

      networks_with_domains = exercise.networks
        .where(ignore_root_domain: true)
        .reject { |network| network.domain.blank? }

      networks_by_upper_domain = group_networks_by_domain_hierarchy(networks_with_domains)

      networks_by_upper_domain.each do |upper_domain, networks|
        if upper_domain.match?(/}}/)
          _, _, upper_domain = upper_domain.rpartition(/}}\.?/)
        end

        domain = find_or_create_domain(exercise, upper_domain)
        create_domain_bindings_for_networks(networks, domain, strip_suffix: upper_domain)
      end
    end

    def process_fallback_domains(exercise)
      puts 'No root domain or networks with ignore_root_domain = true found, creating domains from networks'

      exercise.networks.each do |network|
        next unless network.domain.present?

        domain = find_or_create_domain(exercise, network.domain)
        create_domain_binding(network, domain, '')
      end
    end

    def group_networks_by_domain_hierarchy(networks)
      # Sort by domain length to process shortest domains first
      networks_by_length = networks.sort_by { |network| network.domain.length }
      result = {}

      while (current_network = networks_by_length.shift)
        current_domain = current_network.domain

        # Find all networks that end with the current domain
        matching_networks = [current_network]
        remaining_networks = []

        networks_by_length.each do |network|
          if network.domain.end_with?(current_domain)
            matching_networks << network
          else
            remaining_networks << network
          end
        end

        result[current_domain] = matching_networks
        networks_by_length = remaining_networks
      end

      result
    end

    def create_domain_bindings_for_networks(networks, domain, strip_suffix: false)
      # Group networks by rendered domain template to avoid duplicates
      networks_by_rendered_domain = networks.group_by do |network|
        render_liquid_template(network.domain)
      end

      networks_by_rendered_domain.each do |_, grouped_networks|
        name = calculate_binding_name(grouped_networks.first.domain, strip_suffix)

        grouped_networks.each do |network|
          create_domain_binding(network, domain, name)
        end
      end
    end

    def calculate_binding_name(domain, strip_suffix)
      if strip_suffix
        domain.gsub(/\.?#{Regexp.escape(strip_suffix)}$/, '')
      else
        domain
      end
    end

    def render_liquid_template(domain_template)
      template_vars = { 'team_nr' => 1, 'team_nr_str' => '1' }
      Liquid::Template.parse(domain_template).render(template_vars)
    rescue Liquid::Error => e
      puts "Warning: Failed to parse Liquid template '#{domain_template}': #{e.message}"
      domain_template
    end

    def find_or_create_domain(exercise, name)
      exercise.domains.where(name: name&.strip).first_or_create!
    rescue ActiveRecord::RecordInvalid => e
      puts "Error creating domain '#{name}': #{e.message}"
      raise
    end

    def create_domain_binding(network, domain, name)
      network.domain_bindings.where(domain: domain, name: name&.strip).first_or_create!
    rescue ActiveRecord::RecordInvalid => e
      puts "Error creating domain binding for network '#{network.name}': #{e.message}"
      raise
    end
end
