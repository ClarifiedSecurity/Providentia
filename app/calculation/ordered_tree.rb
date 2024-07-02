# frozen_string_literal: true

class OrderedTree < Patterns::Calculation
  private
    def result
      build_array(
        subject
          .select("#{subject.table_name}.*", "lower(#{subject.table_name}.name)")
          .order("lower(#{subject.table_name}.name) asc")
          .arrange
      )
    end

    def build_array(hash)
      hash.flat_map do |root, subtree|
        if subtree.empty?
          root
        else
          [root, Naturally.sort(build_array(subtree), by: :downcased_name)].flatten
        end
      end
    end
end
