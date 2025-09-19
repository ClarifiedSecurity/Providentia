# frozen_string_literal: true

module AddressHelper
  def bindings_to_options(bindings)
    bindings.map { |binding|
      [
        binding.id,
        LiquidReplacer.new(binding.full_name).iterate { "[ #{it.name.name} ]" }
      ]
    }
  end
end
