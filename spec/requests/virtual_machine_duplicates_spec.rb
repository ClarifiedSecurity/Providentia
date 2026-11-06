# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Duplicate virtual machine', type: :request do
  let(:exercise) { create(:exercise) }
  let(:source) { create(:virtual_machine, exercise:, actor: exercise.actors.first, name: 'web-1') }
  let(:user) { create(:user) }
  let(:role) { :actor_dev }
  let(:path) { exercise_virtual_machine_duplicate_path(exercise, source) }

  before do
    create(:role_binding, user_email: user.email, role:, exercise:, actor: source.actor)
    sign_in user
  end

  it 'offers the Duplicate button on the VM page and the list' do
    get exercise_virtual_machine_path(exercise, source)
    expect(response.body).to include(path)
    get exercise_virtual_machines_path(exercise)
    expect(response.body).to include(path)
  end

  it 'shows the form prefilled with <name>-copy' do
    get path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include('value="web-1-copy"')
  end

  it 'creates the copy and redirects to it' do
    expect { post path, params: { duplicate: { name: 'web-2' } } }.to change(VirtualMachine, :count).by(1)
    expect(response).to redirect_to(exercise_virtual_machine_path(exercise, VirtualMachine.find_by(name: 'web-2')))
  end

  it 'rejects an existing name' do
    source
    expect { post path, params: { duplicate: { name: 'web-1' } } }.not_to change(VirtualMachine, :count)
    expect(response).to have_http_status(400)
  end

  it 'rejects a case-variant of an existing name' do
    source
    expect { post path, params: { duplicate: { name: 'WEB-1' } } }.not_to change(VirtualMachine, :count)
    expect(response).to have_http_status(400)
  end

  it 'rejects a blank name' do
    source
    expect { post path, params: { duplicate: { name: '' } } }.not_to change(VirtualMachine, :count)
    expect(response).to have_http_status(400)
  end

  it 'renders errors when the copy is invalid' do
    source
    expect { post path, params: { duplicate: { name: 'x' * 64 } } }.not_to change(VirtualMachine, :count)
    expect(response).to have_http_status(400)
    expect(response.body).to include('too long')
    expect(response.body).not_to include('Name is too long')
    expect(response.body).not_to match(/Name\s+Name/i)
  end

  [ActiveRecord::RecordNotSaved, ActiveRecord::RecordNotUnique].each do |error|
    it "renders a base error instead of a 500 on #{error}" do
      source
      allow(DuplicateVirtualMachine).to receive(:result_for).and_raise(error.new('boom'))
      expect { post path, params: { duplicate: { name: 'web-2' } } }.not_to change(VirtualMachine, :count)
      expect(response).to have_http_status(400)
      expect(response.body).to include('could not be duplicated')
    end
  end

  context 'as actor_readonly' do
    let(:role) { :actor_readonly }

    it 'hides the Duplicate button' do
      get exercise_virtual_machine_path(exercise, source)
      expect(response.body).not_to include(path)
    end

    it 'refuses to show the form' do
      get path
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end

    it 'refuses to create' do
      source
      expect { post path, params: { duplicate: { name: 'web-2' } } }.not_to change(VirtualMachine, :count)
      expect(flash[:error]).to eq 'You are not authorized to perform this action.'
    end
  end
end
