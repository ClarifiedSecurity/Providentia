# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :role_binding do
    exercise { nil }
    actor { nil }
    role { 1 }
    user_email { 'MyString' }
    user_resource { 'MyString' }
  end

  factory :actor_number_config do
    actor
    config_map { {} }
    name { 'MyString' }
    matcher { [] }
  end

  factory :customization_spec do
    virtual_machine
    user
    mode { 'host' }
    sequence(:name) { |n| "CoolSpec#{n}" }
    role_name { 'MyString' }
    description { 'MyText' }
  end

  factory :capability do
    sequence(:name) { |n| "Capability #{n}" }
    sequence(:slug) { |n| "capability#{n}" }
    actors { [exercise.actors.sample] }
    exercise
  end

  factory :address do
    network_interface
    mode { 1 }
    offset { 'MyString' }
    dns_enabled { false }
  end

  factory :address_pool do
    name { 'Pool' }
    network
    network_address { '1.2.3.0/24' }
  end

  factory :exercise do
    name { 'Crocked Fields' }
    abbreviation { Faker::Alphanumeric.alpha(number: 5) }
    dev_resource_name { "#{abbreviation.upcase}_GT" }
    dev_red_resource_name { "#{abbreviation.upcase}_RT" }
    actors { build_list(:actor, 2, exercise: instance) }
  end

  factory :virtual_machine do
    sequence(:name) { |n| "CoolTarget#{n}" }
    association :system_owner, factory: :user
    actor
    operating_system
    exercise
  end

  factory :operating_system do
    name { Faker::Computer.os }
    cloud_id { name.to_url + rand(999).to_s }

    cpu { 2 }
    ram { 4 }
    primary_disk_size { 20 }
  end

  factory :actor do
    name { Faker::Company.department }
    abbreviation { name.dasherize }
    exercise

    trait :numbered do
      number { 3 }
    end

    trait :numbered_2 do
      number { 2 }
    end
  end

  factory :network do
    name { Faker::Internet.domain_name }
    abbreviation { Faker::Alphanumeric.alpha(number: 5) }
    actor { exercise.actors.sample }
    exercise
  end

  factory :network_interface do
    network
    virtual_machine
  end

  factory :user do
    email { Faker::Internet.email }
    resources { [UserPermissions::BASIC_ACCESS] }
  end

  factory :api_token do
    user
  end

  factory :service do
    exercise
    name { 'Some service' }
  end

  factory :service_subject do
    service
  end

  factory :check do
    service
  end

  factory :instance_metadatum do
    customization_spec { nil }
    instance { 'MyString' }
    metadata { '' }
  end

  factory :credential do
    credential_set

    name { Faker::Name.name }
    password { Faker::Internet.password }
  end

  factory :credential_set do
    exercise
    name { 'MyString' }
  end

  factory :credential_binding do
    credential_set { nil }
    customization_spec { nil }
  end
end
