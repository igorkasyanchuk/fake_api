module FakeApi
  class Route
    attr_reader :route, :response, :status, :headers

    def initialize(route:, response: nil, status: 200, headers: {})
      @route    = route
      @response = response
      @status   = status
      @headers  = headers
      self
    end

    def with_status(new_status)
      @status = new_status
      self
    end

    def and_return(new_response = nil, &block)
      @response = new_response || block
      self
    end

    def with_headers(new_headers)
      @headers = new_headers
      self
    end
  end
end