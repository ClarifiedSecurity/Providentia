# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API v3 specs', type: :request do
  let(:exercise) { create(:exercise) }

  let!(:user) { create(:user, api_tokens: [api_token]) }
  let!(:role_binding) { create(:role_binding, exercise:, user_email: user.email, role: :environment_admin) }
  let(:api_token) { create(:api_token) }
  let(:headers) { { 'Authorization' => "Token #{api_token.token}" } }

  subject(:do_request) { get "/api/v3/#{exercise.slug}/actors", headers: }
  subject { do_request; response }

  it { is_expected.to be_successful }

  it 'lists actors' do
    subject # do request
    expect(response.parsed_body).to have_key('result')

    exercise.actors.each do |actor|
      expect(response.parsed_body['result']).to include(
        {
          id: ActorAPIName.result_for(actor),
          name: actor.name,
          description: actor.description,
          instances: [],
          config_map: actor.prefs,
          children: [],
          numbered_configurations: []
        }.deep_stringify_keys
      )
    end
  end

  context 'with numbered actors' do
    let!(:numbered_actor) { create(:actor, :numbered, exercise:) }
    let!(:config) {
      create(:actor_number_config,
        actor: numbered_actor,
        matcher: numbered_actor.all_numbers.take(2),
        config_map: { special: true },
      )
    }

    it { is_expected.to be_successful }

    it 'lists actors' do
      subject # do request

      expect(response.parsed_body['result']).to include(
        {
          id: ActorAPIName.result_for(numbered_actor),
          name: numbered_actor.name,
          description: numbered_actor.description,
          instances: numbered_actor.all_numbers.map do |nr|
            map = config.config_map if config.matcher.include?(nr.to_s)
            {
              number: nr,
              config_map: map || {}
            }
          end,
          config_map: numbered_actor.prefs,
          children: [],
          numbered_configurations: [
            {
              id: config.name.to_url,
              name: config.name,
              matcher: config.matcher,
              config_map: config.config_map
            }
          ]
        }.deep_stringify_keys
      )
    end
  end

  context 'with nested actors' do
    let!(:child_actor) { create(:actor, parent: exercise.actors.sample, exercise:) }

    it { is_expected.to be_successful }
    it 'should list the child actor in response as a tree' do
      subject
      expect(response.parsed_body['result']).to include(
        {
          id: ActorAPIName.result_for(child_actor.parent),
          name: child_actor.parent.name,
          description: child_actor.parent.description,
          instances: [],
          config_map: child_actor.parent.prefs,
          children: [{
            id: ActorAPIName.result_for(child_actor),
            name: child_actor.name,
            description: child_actor.description,
            instances: [],
            config_map: child_actor.prefs,
            children: [],
            numbered_configurations: []
          }],
          numbered_configurations: []
        }.deep_stringify_keys
      )
    end

    context 'with numbers on root' do
      before { child_actor.root.update(number: 2) }

      it { is_expected.to be_successful }
      it 'should list the child actor in response as a tree' do
        subject
        expect(response.parsed_body['result']).to include(
          {
            id: ActorAPIName.result_for(child_actor.parent),
            name: child_actor.parent.name,
            description: child_actor.parent.description,
            instances: child_actor.root.all_numbers.map do |nr|
              {
                number: nr,
                config_map: {}
              }
            end,
            config_map: child_actor.parent.prefs,
            children: [{
              id: ActorAPIName.result_for(child_actor),
              name: child_actor.name,
              description: child_actor.description,
              instances: child_actor.root.all_numbers.map do |nr|
                {
                  number: nr,
                  config_map: {}
                }
              end,
              config_map: child_actor.prefs,
              children: [],
              numbered_configurations: []
            }],
            numbered_configurations: []
          }.deep_stringify_keys
        )
      end
    end
  end

  context 'without headers' do
    let(:headers) { {} }

    it { is_expected.to_not be_successful }

    it 'should return 401' do
      expect(subject.status).to eq 401
    end
  end

  context 'with headers for a different exercise' do
    let!(:user) { create(:user, api_tokens: [api_token]) }
    let!(:role_binding) { create(:role_binding, exercise:, user_email: 'some.random@address', role: :environment_admin) }

    it { is_expected.to_not be_successful }

    it 'should return 404' do
      expect(subject.status).to eq 404
    end
  end
end
