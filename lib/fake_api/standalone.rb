require "rails"
require "fake_api"
require "action_controller/railtie"
require "active_support/railtie"

class FakeApiApp < Rails::Application
  config.session_store :cookie_store, key: '_fake_session'
  config.secret_key_base = SecureRandom.hex(30)
  Rails.logger           = Logger.new($stdout)
  config.hosts.clear
end

class ApplicationController < ActionController::Base; end

module FakeApi
  class Standalone
    def Standalone.app(on: '/api')
      FakeApiApp.routes.append do
        mount FakeApi::Engine => on
      end

      FakeApiApp.initialize!

      FakeApiApp
    end
  end
end

def method_missing(m, *args, &block)
  if FakeApi::FakeApiData.instance.respond_to?(m)
    FakeApi::FakeApiData.instance.send(m, *args, &block)
  else
    super
  end
end