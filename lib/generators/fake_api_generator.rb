class FakeApiGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def create_fake_api_file
    if file_name.blank?
      puts "Sample: rails g fake_api Product"
      exit
    end
    template 'routing.rb', File.join('app/fake_api', "#{file_name}_routing.rb")
    template 'factory.rb', File.join('app/fake_api', "#{file_name}_factory.rb")
  end

  def class_name
    args[0]&.strip
  end

  def file_name
    class_name&.underscore
  end
end