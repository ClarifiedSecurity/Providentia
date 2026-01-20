# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
gem 'rails', '~> 8.1.0'
gem 'pg'
gem 'sqlite3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'puma'
gem 'oj', '~> 3.16'
gem 'rails-patterns'
gem 'friendly_id', '~> 5.6.0'
gem 'nilify_blanks', '~> 1.4'
gem 'data_migrate'
gem 'solid_cable'
gem 'solid_queue'
gem 'solid_cache'
gem 'jwt'
gem 'dry-initializer', '~> 3.2'

# frontend
gem 'haml-rails', '~> 3.0'
gem 'turbo-rails', '~> 2.0'
gem 'importmap-rails', '~> 2.1'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'view_component'
gem 'view_component-contrib'

# functionality
gem 'stringex', '~> 2.8', require: 'stringex_lite'
gem 'http', '~> 5.0'
gem 'liquid', '~> 5.11'
gem 'rgl'
gem 'acts-as-taggable-on', '~> 13.0'
gem 'ipaddress', github: 'ipaddress-gem/ipaddress'
gem 'simple_form', '~> 5.3'
gem 'ancestry'
gem 'paper_trail'
gem 'kaminari'
gem 'naturally', '~> 2.2'

# markdown
gem 'redcarpet'
gem 'rouge'

# auth
gem 'devise'
gem 'omniauth', '~> 2.0'
gem 'omniauth_openid_connect'
gem 'omniauth-rails_csrf_protection'
gem 'action_policy'

# frontend
gem 'propshaft'

# monitoring
gem 'sentry-ruby'
gem 'sentry-rails'

group :development, :test do
  gem 'bundler-audit', '~> 0.9.2'
  gem 'brakeman'
  gem 'rubocop-rails_config'
  gem 'byebug', platforms: %i[mri windows]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-pg-extras'
  gem 'database_cleaner-active_record'
  gem 'faker', '~> 3.4'
end

group :development do
  gem 'listen'
  gem 'web-console', '>= 3.3.0'
  gem 'bullet'
  gem 'rack-mini-profiler'
  # For memory profiling
  gem 'memory_profiler'

  # For call-stack profiling flamegraphs
  gem 'flamegraph'
  gem 'stackprof'

  gem 'silencer'
  gem 'awesome_print', '~> 1.9'
  gem 'pry-rails', '~> 0.3.9'
end
