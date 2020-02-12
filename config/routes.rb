FakeApi::Engine.routes.draw do
  match '/*path', to: 'fake#data', via: :all

  # to get mounted route
  get '/__test__test', to: 'fake#data', as: :__test__test
end