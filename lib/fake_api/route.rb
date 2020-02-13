module FakeApi
  class Route
    attr_reader :route, :response, :status, :headers, :cookies, :session

    def initialize(route:, response: nil, status: 200, headers: {}, cookies: {}, session: {})
      @route    = route
      @response = response
      @status   = status
      @headers  = headers
      @cookies  = cookies
      @session  = session
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

    def with_cookies(new_cookies)
      @cookies = new_cookies
      self
    end

    def with_session(new_session)
      @session = new_session
      self
    end
  end
end