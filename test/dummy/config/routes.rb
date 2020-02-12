Rails.application.routes.draw do
  mount FakeApi::Engine => '/api'

  root to: 'home#index'
end
