FakeApi::Engine.routes.draw do
  match '/*path', to: 'fake#data', via: :all
  get '/hello', to: 'fake#data'
end

Rails.application.routes.draw do
  mount_fake_api_routes
end