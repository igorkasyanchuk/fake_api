module FakeApi
  class Engine < ::Rails::Engine

    config.to_prepare do
      Engine.load_fake_api_dependencies
    end    

    config.after_initialize do |app|
      app.config.paths.add 'app/fake_api', eager_load: true
      app.config.autoload_paths += Dir["#{Rails.root}/app/fake_api/**/*.rb"]
    end

    def Engine.load_fake_api_dependencies
      Dir["#{Rails.root}/app/fake_api/**/*.rb"].each do |file|
        require_dependency file
      end
    end
  end
end
