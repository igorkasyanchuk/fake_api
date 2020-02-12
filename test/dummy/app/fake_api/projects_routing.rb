class ProjectsRouting < FakeApi::Routing
  get '/projects', -> { create_list(:project, 5) }
  get /^\/projects\/\d+$/, -> {
    object(:project)
  }
  post '/projects', -> { object(:project).merge({created: 'ok'}) }
end