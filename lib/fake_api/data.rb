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

    def factory(name, &block)
      response = Factory.new(name: name, value: block)
      @responses[name] = response
    end

    def route(request_method, route:, &block)
      e = Route.new(route: route)
      @routes[request_method.upcase] ||= {}
      @routes[request_method.upcase][route] = e
    end

    def get(path)
      route("GET", route: path)
    end

    def post(path)
      route("POST", route: path)
    end

    def put(path)
      route("PUT", route: path)
    end

    def patch(path)
      route("PATCH", route: path)
    end

    def delete(path)
      route("DELETE", route: path)
    end

    def object(something)
      response_or_value(something)
    end
    alias :create :object
    alias :build :object

    def create_list(something, amount)
      result = []
      amount.times { result << response_or_value(something) }
      result
    end

    def response_or_value(e)
      if e.is_a?(Symbol)
        if response = FakeApiData.instance.responses[e]
          response.value.call
        else
          nil
        end
      else
        e
      end
    end
  end

end