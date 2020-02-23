require "fake_api/engine"
require "faker"
require "ostruct"

require_relative './fake_api/data.rb'
require_relative './fake_api/base.rb'
require_relative './fake_api/route.rb'
require_relative './fake_api/factory.rb'
require_relative './fake_api/handler.rb'
require_relative './fake_api/debug.rb'

require_relative './generators/fake_api_generator.rb' rescue nil

module FakeApi
end