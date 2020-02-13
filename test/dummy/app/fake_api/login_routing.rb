class LoginRouting < FakeApi::Routing
  post('/auth')
    .and_return { { status: "OK" } }
    .with_cookies({x: "A"})
    .with_session({y: "B"})
    .with_headers({token: "C"})

  get('/return-js').and_return do
    "alert('returned from fake_api');"
  end
end