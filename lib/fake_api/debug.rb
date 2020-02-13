module FakeApi

  class Debug

    def Debug.status
      result = {}
      result[:factories] = []
      result[:responses] = {}

      FakeApiData.instance.responses.each do |name, response|
        result[:factories] << name
      end

      FakeApiData.instance.routes.each do |request_method, info|
        result[:responses][request_method] ||= []
        info.each do |(path, route)|
          result[:responses][request_method] << {
            route: route.route,
            status: route.status
          }
        end
      end
      result
    end

  end

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