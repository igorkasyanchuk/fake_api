module FakeApi

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

    def patch(*options)
      route("PATCH", *options)
    end

    def delete(*options)
      route("DELETE", *options)
    end

    def object(something)
      response_or_value(something)
    end

    def create_list(something, amount)
      result = []
      amount.times { result << response_or_value(something) }
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

end