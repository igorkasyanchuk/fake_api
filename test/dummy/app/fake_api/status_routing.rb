class StatusRouting < FakeApi::Routing
  post('/post-status').and_return do
    {
      created: 'ok',
      status: Project.count,
      data: object(:complex)
    }
  end

  get('/return-js').and_return do
    "alert('returned from fake_api');"
  end

  get('/hash').and_return do
    { status: "OK" }
  end
end