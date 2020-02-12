require 'test_helper'

class FakeApiControllerTest < ActionDispatch::IntegrationTest
  test "should projects.json" do
    get '/api/projects.json'
    assert_response :success
    assert response.body.include?('[{"id":')
  end

  test "should post to projects.json" do
    post '/api/projects.json'
    assert_response :success
    assert response.body.include?('{"id":')
  end

  test "should project.json" do
    get '/api/projects/1.json'
    assert_response :success
    assert response.body.include?('{"id":')
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
    #assert_response :error
    assert response.body.include?('Route "/api/no-real" was not found')
  end
end