require "fake_api/engine"
require "faker"
require "pry"
require "ostruct"

module FakeApi
  class BaseStuct < OpenStruct
    def initialize(name, value)
      super(name: name, value: value)
    end
  end
  Response = BaseStuct
  Route    = BaseStuct

  class FakeApiData
    attr_reader :responses, :routes

    def FakeApiData.instance
      @@instance ||= FakeApiData.new
    end

    def initialize
      @responses = {}
      @routes    = {}
    end

    def response(name, value = -> {}, &block)
      response = Response.new(name, value)
      response.instance_eval(&block) if block_given?
      @responses[name] = response
    end

    def route(request_method, path, value = -> {}, &block)
      route = Route.new(path, value)
      route.instance_eval(&block) if block_given?
      @routes[request_method.upcase] ||= {}
      @routes[request_method.upcase][path] = route
    end

    def get(*options)
      route("GET", *options)
    end

    def post(*options)
      route("POST", *options)
    end

    def put(*options)
      route("PUT", *options)
    end

    def put(*options)
      route("PATCH", *options)
    end

    def put(*options)
      route("DELETE", *options)
    end

    def object(something)
      response_or_value(something)
    end

    def create_list(something, amount)
      result = []
      amount.times do |index|
        result << response_or_value(something)
      end
      result
    end

    def response_or_value(something)
      if something.is_a?(Symbol)
        if response = FakeApiData.instance.responses[something]
          response.value.call
        else
          nil
        end
      else
        something
      end
    end
  end

  def FakeApi.debug
    puts "Responses:"
    FakeApiData.instance.responses.each do |name, response|
      puts response.debug
      puts "=========="
    end

    puts "---"

    puts "Routes:"
    FakeApiData.instance.routes.each do |request_method, info|
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
      route = FakeApiData.instance.routes.fetch(request_method, {})["/#{path}"]
      if route
        route.value.call
      else
        raise "Route #{path} not found. Please edit your rounting file for the fake_api gem. \n#{available}"
      end
    end

    private

    def Handler.available
      FakeApiData.instance.routes.collect do |route|
        route[0].name
      end.join("\n")
    end
  end

  class Base
    mattr_accessor :data
    @@data = FakeApiData.instance

    class << self
      delegate_missing_to :data
    end
  end

  Routing = Base
  Factory = Base
end

# module FakeApi
#   extend ActiveSupport::Autoload

#   eager_autoload do
#     autoload :Handler
#     autoload :Route
#     autoload :Response
#     autoload :Factory
#     autoload :Routing
#     autoload :Handler
#     autoload :FakeApiData
#   end
# end