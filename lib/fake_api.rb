require "fake_api/engine"
require "faker"
require "pry"

module ActionDispatch::Routing
  class Mapper
    def mount_fake_api_routes(options = {})
      mount FakeApi::Engine => '/fake_api', :as => options[:as] || 'fake_api'
    end
  end
end

module FakeApi

  class Response
    attr_reader :name, :value

    def initialize(name, value)
      @name  = name
      @value = value
    end

    def debug
      name.to_s + value.source
    end
  end

  class Route
    attr_reader :path, :value

    def initialize(path, value)
      @path  = path
      @value = value
    end

    def debug
      path
    end
  end

  class FakeApiSchema
    attr_reader :responses, :routes

    def FakeApiSchema.instance
      @@instance ||= FakeApiSchema.new
    end

    def initialize
      @responses = {}
      @routes    = {}
    end

    def define_response(name, value = -> {}, &block)
      response = Response.new(name, value)
      response.instance_eval(&block) if block_given?
      @responses[name] = response
    end

    def define_route(request_method, path, value = -> {}, &block)
      route = Route.new(path, value)
      route.instance_eval(&block) if block_given?
      @routes[request_method.upcase] ||= {}
      @routes[request_method.upcase][path] = route
    end

    def get(*options)
      define_route("GET", *options)
    end

    def post(*options)
      define_route("POST", *options)
    end

    def put(*options)
      define_route("PUT", *options)
    end

    def put(*options)
      define_route("PATCH", *options)
    end

    def put(*options)
      define_route("DELETE", *options)
    end
  end

  def FakeApi.debug
    puts "Responses:"
    FakeApiSchema.instance.responses.each do |name, response|
      puts response.debug
      puts "=========="
    end

    puts "---"

    puts "Routes:"
    FakeApiSchema.instance.routes.each do |request_method, info|
      puts request_method
      info.each do |(path, route)|
        puts route.debug
      end
      puts "=========="
    end
  end
end

module FakeApi
  class Handler
    def Handler.handle(request_method, path:, params: {}, headers: {})
      route = FakeApiSchema.instance.routes.fetch(request_method, {})["/#{path}"]
      route.value.call
    end
  end

  class Model
    mattr_accessor :schema
    @@schema = FakeApiSchema.instance

    class << self
      delegate_missing_to :schema
    end

    def self.create_list(something, amount)
      result = []
      amount.times do |index|
        result << response_or_value(something)
      end
      result
    end

    def self.response_or_value(something)
      if something.is_a?(Symbol)
        if response = FakeApiSchema.instance.responses[something]
          response.value.call
        else
          nil
        end
      else
        something
      end
    end
  end
end

module FakeApi
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Handler
    autoload :Route
    autoload :Response
    autoload :Model
    autoload :Handler
    autoload :FakeApiSchema
  end
end
