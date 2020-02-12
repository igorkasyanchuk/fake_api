class Routing < FakeApi::Routing

  get '/all-project', -> { response(:project, 2) }
  get '/all-projects', -> { create_list(:project, 2) }
  get '/my-last-project', -> {
    {
      data: {
        project: response(:project)
      }
    }
  }

  get '/one', -> {
    {
      title: 'here',
      count: Project.count
    }
  }

  post '/one', -> {
    {
      status: :ok
    }
  }

  post '/some-js', -> {
    "alert(1);"
  }  

  get '/xxx/some-js', -> {
    "alert(2);"
  }

end