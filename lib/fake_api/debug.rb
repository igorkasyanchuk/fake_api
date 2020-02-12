module FakeApi

  class Debug

    def Debug.status
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