# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

OperatingSystem.where(name: 'Linux', cloud_id: 'linux').first_or_create!
OperatingSystem.where(name: 'macOS', cloud_id: 'macos').first_or_create!
OperatingSystem.where(name: 'Windows', cloud_id: 'windows').first_or_create!
OperatingSystem.where(name: 'Network devices', cloud_id: 'networkdevices').first_or_create!

if Rails.env.development?
  ex = Exercise.where(name: 'Test Exercise', abbreviation: 'TE').first_or_create!
  ex.actors.reload
  # admins
  ex.role_bindings
    .where(role: :environment_admin, user_resource: "#{Rails.configuration.resource_prefix}TE_Admin")
    .first_or_create

  # basic access
  %w(TE_Organizer TE_Developer TE_RT_Member TE_BT_Member).each do
    ex.role_bindings
      .where(role: :environment_member, user_resource: "#{Rails.configuration.resource_prefix}#{_1}")
      .first_or_create
  end

  # RT role
  ex.role_bindings
    .where(
      role: :actor_dev,
      user_resource: "#{Rails.configuration.resource_prefix}TE_RT_Member",
      actor: ex.actors.find_by(abbreviation: 'rt')
    ).first_or_create

  # Dev role
  ex.role_bindings
    .where(
      role: :actor_dev,
      user_resource: "#{Rails.configuration.resource_prefix}TE_Developer",
      actor: ex.actors.find_by(abbreviation: 'infra')
    ).first_or_create
  ex.role_bindings
    .where(
      role: :actor_dev,
      user_resource: "#{Rails.configuration.resource_prefix}TE_Developer",
      actor: ex.actors.find_by(abbreviation: 'bt')
    ).first_or_create

  # BT role
  ex.role_bindings
    .where(
      role: :actor_readonly,
      user_resource: "#{Rails.configuration.resource_prefix}TE_BT_member",
      actor: ex.actors.find_by(abbreviation: 'bt')
    ).first_or_create

end

CustomCheckSubject.where(base_class: 'CustomizationSpec', meaning: 'self').first_or_create!
CustomCheckSubject.where(base_class: 'Network', meaning: 'First egress NIC').first_or_create!
CustomCheckSubject.where(base_class: 'Network', meaning: 'Connection NIC').first_or_create!
