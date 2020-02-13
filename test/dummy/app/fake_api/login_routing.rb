class LoginRouting < FakeApi::Routing
  post('/auth')
    .and_return { { status: "OK" } }
    .with_cookies({x: "A"})
    .with_session({y: "B"})
    .with_headers({token: "C"})
end