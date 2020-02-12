class Factory < FakeApi::Factory

  response :xxx, -> {
    {x: 1, y: 2}
  }

  response :project, -> {
    [
      {
        title: Faker::Company.name,
        description: Faker::Company.catch_phrase,
        type: Faker::Company.type
      }, 
      object(:xxx)
    ]
  }

end