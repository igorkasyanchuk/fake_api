class ProjectsRouting < FakeApi::Routing
  get('/projects')
    .and_return { create_list(:project, 5) }
    .with_status(202)
    .with_headers({TOKEN: "SECRET"})

  get(%r{/projects/\d+$}).and_return { object(:project) }

  post('/projects').and_return { object(:project).merge({created: 'ok'}) }

  delete(%r{/projects/\d+$}).and_return { { result: :deleted } }.with_status(333)
end