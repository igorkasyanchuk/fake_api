class RoutingOther < FakeApi::Routing
  post '/post-status', -> {
    {
      created: 'ok',
      status: Project.count,
      data: object(:complex)
    }
  }

  get '/return-js', -> {
    "alert(1);"
  }
end