class Factory < FakeApi::Factory

  response :user, -> {
    {
      id: rand(100),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.first_name,
      avatar_url: Faker::Avatar.image(size: '128x128')
    }
  }

  response :project, -> {
    {
      id: rand(1_000),
      title: Faker::Company.name,
      description: Faker::Company.catch_phrase,
      type: Faker::Company.type,
      author: object(:user)
    }
  }

  response :complex, -> {
    [
      projects: create_list(:project, 2),
      user: object(:user)
    ]
  }

end