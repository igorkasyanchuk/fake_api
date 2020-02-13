class <%= class_name %>Routing < FakeApi::Routing
  get('/projects').and_return           { create_list(:project, 5) }.with_status(202).with_headers({TOKEN: "SECRET"})

  get(%r{/projects/\d+$})
    .and_return { object(:project) }
    .with_cookies({x: "A"})
    .with_session({y: "B"})
    .with_headers({token: "C"})

  post('/projects').and_return          { object(:project).merge({created: 'ok'}) }

  delete(%r{/projects/\d+$}).and_return { { result: :deleted } }.with_status(200)
end