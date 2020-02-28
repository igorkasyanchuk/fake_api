# start it:
# rackup -p 3000 -o 0.0.0.0

# create file
# config.ru

require 'fake_api/standalone'

factory(:user) do
  {
    id: rand(100),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(100)
  }
end

get('/users').and_return do
  create_list(:user, 5)
end

get(%r{/users/\d+$}).and_return do
  object(:user)
end

run FakeApi::Standalone.app on: '/api'