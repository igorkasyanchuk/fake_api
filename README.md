# Fake API

[![Build Status](https://travis-ci.org/igorkasyanchuk/fake_api.svg?branch=master)](https://travis-ci.org/igorkasyanchuk/fake_api)

The **fastest** way to prototype API with most real dummy data, and provide them to other team members.

Instead of creating many new controllers and actions, and sending random data like `"First name #{rand(100)}"` you'll get real data for developing/testing.

Gem has a syntax similar to rails routes, factory bot, and uses faker to generate dummy data.

![Demo](/docs/fake_api_demo.gif)

Features:

* fast API prototyping
* clear and familiar syntax
* Faker for test data generation
  * including links to images if needed
* manage cookies, session, headers with fake response
* executes your factories in real-time, so you always get fresh and random data
* has generator
* has standalone mode (see documentation for more details)

## Installation & Usage

Installation process is very simple.

- add `gem 'fake_api'` to the Gemfile
- run `bundle install`
- mount gem in routes.rb `mount FakeApi::Engine => '/api'`
- `rails g fake_api Product`. It will generate factory and routing files.
- edit `app/fake_api/*.rb`, define your routing and factories.
- open `localhost:300/api/projects.json` (see step 5) or `localhost:300/api/projects.xml` (to return XML in API response)
- profit :)

You can keep your routing and factories in many files.

## Examples

Sample of the factory:

```ruby
# app/fake_api/factory.rb
class Factory < FakeApi::Factoring

  # Example of User object
  # you can see that it will generate link to fake image
  factory(:user) do
    {
      id: rand(100),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.first_name,
      avatar_url: Faker::Avatar.image(size: '128x128'),
      age: rand(100)
    }
  end

  # heare you can put "relations" to other factories
  # see "author" node
  factory(:project) do
    {
      id: rand(1_000),
      title: Faker::Company.name,
      description: Faker::Company.catch_phrase,
      type: Faker::Company.type,
      author: object(:user)
    }
  end

  # or have factory which contains from the list of Projects and a single user
  factory(:complex) do
    {
      projects: create_list(:project, 2),
      user: object(:user)
    }
  end

end
```

And sample of routing:

```ruby
# app/fake_api/app_routing.rb
class AppRouting < FakeApi::Routing
  get('/projects').and_return           { create_list(:project, 5) }.with_status(202).with_headers({TOKEN: "SECRET"})
  get(%r{/projects/\d+$}).and_return    { object(:project) }
  post('/projects').and_return          { object(:project).merge({created: 'ok'}) }
  delete(%r{/projects/\d+$}).and_return { { result: :deleted } }.with_status(333)

  post('/auth')
    .and_return { { status: "OK" } }
    .with_cookies({x: "A"})
    .with_session({y: "B"})
    .with_headers({token: "C"})
end
```

## Factory Methods

- `create_list(:factory_name, 10)` to create an array of 10 factories.
- `object(:factory_nane)` to return a factory

## Routing Methods

- `get/post/put/patch/delete` to define route
- `and_return` to specify the response. This response will be converted to FORMAT (json, xml, js, csv(for arrays) etc)
- `with_cookies` to list returned cookies
- `with_session` to list changes in session
- `with_headers` to list returned headers

## Standalone mode

Developing standalone version of the gem:

```bash
cd test
rackup -p 3000 -o 0.0.0.0
```

Edit `config.ru` to change example code.

## Standalone mode

This is an example how you can start just fake_api server and define your factories and responses just inside one single file.

Please check example below and instructions how to start fakea_api in standalone mode.

Since this is a rack app it could be just deployed to the server.

```ruby
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
```

## TODO

- render ERB?
- exclude from code converage generator and dummy app
- make code coverage 100%
- access controller in the gem?
- reload code in standalone app after code changes in dev mode

## Contributing

You are welcome to contribute.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
