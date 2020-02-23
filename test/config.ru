require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rails'
  gem 'fake_api', path: '../'
  gem 'pry'
end

require "rails"
require "action_controller/railtie"

class FakeApiApp < Rails::Application
  config.session_store :cookie_store, :key => '_session'
  config.secret_key_base = SecureRandom.hex(30)
  Rails.logger = Logger.new($stdout)
  config.hosts.clear
end

class ApplicationController < ActionController::Base; end

FakeApiApp.routes.append do
  mount FakeApi::Engine => '/api'
end


class StatusRouting < FakeApi::Inline
  factory(:user) do
    {
      id: rand(100),
      first_name: Faker::Name.first_name,
      age: rand(100)
    }
  end

  get('/xxx').and_return do
    object(:user)
  end
end

FakeApiApp.initialize!

run FakeApiApp