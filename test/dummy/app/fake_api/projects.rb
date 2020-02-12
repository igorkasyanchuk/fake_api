class Projects < FakeApi::Model

  define_response :project, -> {
    {
      title: Faker::Company.name,
      description: Faker::Company.catch_phrase,
      type: Faker::Company.type,
      typex: Faker::Company.type
    }
  }

  get '/all-project', -> { create_list(:project, 2) }
  get '/all-projects', -> { create_list(:project, 5) }
  get '/my-last-project', -> {
    {
      data: {
        project: response(:project)
      }
    }
  }

end

# FakeApi.debug