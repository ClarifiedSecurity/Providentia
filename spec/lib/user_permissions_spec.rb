# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPermissions do
  subject { described_class.result_for(list) }

  context 'invalid list' do
    let(:list) { [] }

    it { should be_falsy }
  end


  context 'invalid list' do
    let(:list) {
      [
        'asdblah'
      ]
    }

    before {
      allow(Rails.configuration).to receive(:resource_prefix).and_return('SOMEPREFIX')
    }

    it { should be_falsy }
  end

  context 'default list' do
    let(:list) {
      [
        "#{described_class::BASIC_ACCESS}",
        "#{Rails.configuration.resource_prefix}RANDOMSTRING"
      ]
    }

    it {
      should eq [
        "#{described_class::BASIC_ACCESS}",
        "#{Rails.configuration.resource_prefix}RANDOMSTRING"
      ]
    }
  end
end
