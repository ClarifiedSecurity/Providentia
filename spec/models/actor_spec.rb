# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Actor do
  context '#default_visibility' do
    let(:actor) { create(:actor, default_visibility:) }

    context 'is public' do
      let(:default_visibility) { 'public' }

      context 'network creation' do
        it 'should set same visibility' do
          network = create(:network, actor:)
          expect(network.visibility).to eq default_visibility
        end
      end

      context 'virtualmachine creation' do
        it 'should set same visibility' do
          virtual_machine = create(:virtual_machine, actor:)
          expect(virtual_machine.visibility).to eq default_visibility
        end
      end
    end

    context 'is actor-only' do
      let(:default_visibility) { 'actor_only' }

      context 'network creation' do
        it 'should set same visibility' do
          network = create(:network, actor:)
          expect(network.visibility).to eq default_visibility
        end
      end

      context 'virtualmachine creation' do
        it 'should set same visibility' do
          virtual_machine = create(:virtual_machine, actor:)
          expect(virtual_machine.visibility).to eq default_visibility
        end
      end
    end
  end
end
