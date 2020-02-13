require 'test_helper'

class FakeApiControllerTest < ActionDispatch::IntegrationTest
  test "should projects.json" do
    get '/api/projects.json'
    assert_response :success
    assert response.body.include?('[{"id":')
    assert_equal response.status, 202
    assert_equal response.headers["TOKEN"], "SECRET"
  end

  test "should post to projects.json" do
    post '/api/projects.json'
    assert_response :success
    assert response.body.include?('{"id":')
  end

  test "should open project.json" do
    get '/api/projects/1.json'
    assert_response :success
    assert response.body.include?('{"id":')
  end

  test "should delete project.json" do
    delete '/api/projects/1.json'
    assert response.body.include?('{"result":')
    assert_equal response.status, 333
  end

  test "should post url" do
    post '/api/post-status.json'
    assert response.body.include?('"created"')
  end

  test "should return-js.js" do
    get '/api/return-js.js', xhr: true
    assert response.body.include?('alert')
  end

  test "should hash.json" do
    get '/api/hash.json'
    assert response.body.include?('OK')
  end

  test "should fail for no real path" do
    post '/api/no-real.json'
    assert response.body.include?('Route "/api/no-real" was not found')
  end

  test "should return cookies, session, headers" do
    post '/api/auth'
    assert_equal "{:status=>\"OK\"}", response.body
    assert_equal "A", cookies["x"]
    assert_equal "B", session["y"]
    assert_equal "C", headers["token"]
  end
end