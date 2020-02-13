# Fake Api

The fastest way to prototype API with real-like data, and provide them to other team members.

Instead of creating many new controllers and actions, and sending random data like `First name #{rand(100)}` you'll get real-like data for developing/testing.

## Usage

Installation process is very simple.

1) add `gem 'fake_api'` to the Gemfile

2) `bundle install`

3) mount gem in routes.rb `mount FakeApi::Engine => '/api'`

4) `rails g fake_api Product`

5) edit `app/fake_api/*.rb`

6) open `localhost:300/api/<path>.js` (see step 5)

## TODO

- CI (travis, github actions, etc)
- render ERB?
- initializer?
- samples?
- generator

## Contributing

You are welcome to contribute.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).