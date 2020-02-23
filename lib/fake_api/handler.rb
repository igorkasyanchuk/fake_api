module FakeApi
  class Handler

    def Handler.handle(method, path:, params: {}, headers: {})
      if route = Handler.resolve(method, path)
        result(
          data: route.response.call,
          status: route.status,
          headers: route.headers,
          cookies: route.cookies,
          session: route.session
        )
      else
        # READ MORE: https://github.com/igorkasyanchuk/fake_api
        result(
          data: %Q{
            Route "#{FakeApi::Engine.mounted_in}/#{path}" was not found. Please edit your fake_api rounting file(s) in app/fake_api/*.rb.\n\nAvailable:
            \n#{available.presence || 'NONE'}
          }.strip,
          status: 500,
        )
      end
    end

    def Handler.result(data:, status: 200, headers: {}, cookies: {}, session: {})
      OpenStruct.new(
        data: data,
        status: status,
        headers: headers,
        cookies: cookies,
        session: session
      )
    end

    private

    def Handler.resolve(method, path)
      FakeApiData.instance.routes.fetch(method, {}).each do |k, v|
        return v if "/#{path}" == k
        return v if k.is_a?(Regexp) && "/#{path}" =~ k
      end
      nil
    end

    def Handler.available
      result = []
      FakeApiData.instance.routes.collect do |method, route|
        route.each do |k, v|
          result << "#{method} #{FakeApi::Engine.mounted_in}#{k}"
        end
      end
      result.sort.join("\n")
    end

  end
end