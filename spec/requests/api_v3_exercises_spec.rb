# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API v3 exercises', type: :request do
  let(:exercise) { create(:exercise) }
  let!(:numbered_actor) { create(:actor, :numbered, exercise:) }

  let!(:user) { create(:user, api_tokens: [api_token], resources: ['WILDWEST']) }
  let!(:role_binding) { create(:role_binding, exercise:, user_resource: 'WILDWEST', role:) }
  let(:role) { :environment_member }
  let(:api_token) { create(:api_token) }
  let(:headers) { { 'Authorization' => "Token #{api_token.token}" } }

  before { get "/api/v3/#{exercise.slug}", headers: }
  subject { response }

  it 'lists exercise info' do
    expect(subject).to be_successful
    expect(subject.parsed_body).to have_key('result')
    expect(subject.parsed_body['result']).to eq(
      {
        id: exercise.slug,
        name: exercise.name,
        description: exercise.description,
        actors: exercise.actors.reload.map do |actor|
          {
            id: actor.abbreviation,
            name: actor.name,
            numbered: { entries: actor.all_numbers },
            config_map: {}
          }
        end
      }.deep_stringify_keys
    )
  end

  context 'with number configs' do
    it 'lists exercise info' do
      expect(subject).to be_successful
      expect(subject.parsed_body).to have_key('result')
      expect(subject.parsed_body['result']).to eq(
        {
          id: exercise.slug,
          name: exercise.name,
          description: exercise.description,
          actors: exercise.actors.reload.map do |actor|
            {
              id: actor.abbreviation,
              name: actor.name,
              numbered: { entries: actor.all_numbers },
              config_map: {}
            }
          end
        }.deep_stringify_keys
      )
    end
  end

  context 'without correct role binding' do
    let!(:role_binding) { create(:role_binding, exercise:, user_resource: ['NOTWILDWEST'], role:) }

    it { is_expected.to have_http_status 404 }
  end
end
