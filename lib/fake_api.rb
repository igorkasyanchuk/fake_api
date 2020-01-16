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
    attr_reader :path
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

    def initialize
      @responses = {}
      @routes    = {}
    end

    def handle(request_method, path:, params: {}, headers: {})
      {
        name: Faker::Name.name,
        email: Faker::Internet.email
      }
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

  mattr_accessor :schema
  @@schema = FakeApiSchema.new

  class << self
    delegate_missing_to :schema
  end

  def self.setup(&block)
    schema.instance_eval(&block)
  end

  def FakeApi.debug
    puts "Responses:"
    schema.responses.each do |name, response|
      puts response.debug
      puts "=========="
    end

    puts "---"

    puts "Routes:"
    schema.routes.each do |request_method, info|
      puts request_method
      info.each do |(path, route)|
        puts route.debug
      end
      puts "=========="
    end
  end
end

FakeApi.setup do

  define_response :project, -> {
    {
      title: Faker::Name.title,
      description: Faker::Data.description
    }
  }

  get '/projects', -> { 10.times.response(:project) }
  get '/my-last-project', -> {
    {
      data: {
        project: response(:project)
      }
    }
  }

end

# to_return(:status => 200, :body => "", :headers => {})

FakeApi.debug