require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "fake_api"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.hosts.clear

    # use ActionDispatch::HostAuthorization
    # use Rack::Sendfile
    # use ActionDispatch::Static
    # use ActionDispatch::Executor
    # use ActiveSupport::Cache::Strategy::LocalCache::Middleware
    # use Rack::Runtime
    # use Rack::MethodOverride
    # use ActionDispatch::RequestId
    # use ActionDispatch::RemoteIp
    # use Sprockets::Rails::QuietAssets
    # use Rails::Rack::Logger
    # use ActionDispatch::ShowExceptions
    # use ActionDispatch::DebugExceptions
    # use ActionDispatch::ActionableExceptions
    # use ActionDispatch::Reloader
    # use ActionDispatch::Callbacks
    # use ActiveRecord::Migration::CheckPending
    # use ActionDispatch::Cookies
    # use ActionDispatch::Session::CookieStore
    # use ActionDispatch::Flash
    # use ActionDispatch::ContentSecurityPolicy::Middleware
    # use Rack::Head
    # use Rack::ConditionalGet
    # use Rack::ETag
    # use Rack::TempfileReaper
    # run Dummy::Application.routes

    config.middleware.delete ActionDispatch::HostAuthorization
    config.middleware.delete Rack::Sendfile
    config.middleware.delete ActionDispatch::Static
    config.middleware.delete ActionDispatch::Executor
    config.middleware.delete ActiveSupport::Cache::Strategy::LocalCache::Middleware
    config.middleware.delete Rack::Runtime
    config.middleware.delete Rack::MethodOverride
    config.middleware.delete ActionDispatch::RequestId
    config.middleware.delete ActionDispatch::RemoteIp
    config.middleware.delete Sprockets::Rails::QuietAssets
    config.middleware.delete Rails::Rack::Logger
    config.middleware.delete ActionDispatch::ShowExceptions
    config.middleware.delete ActionDispatch::DebugExceptions
    config.middleware.delete ActionDispatch::ActionableExceptions
    config.middleware.delete ActionDispatch::Reloader
    config.middleware.delete ActionDispatch::Callbacks
    config.middleware.delete ActiveRecord::Migration::CheckPending
    config.middleware.delete ActionDispatch::ContentSecurityPolicy::Middleware
    config.middleware.delete Rack::Head
    config.middleware.delete Rack::ConditionalGet
    config.middleware.delete Rack::ETag
    config.middleware.delete Rack::TempfileReaper
    config.middleware.delete Dummy::Application.routes

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

