require 'test_helper'

class FakeApi::Test < ActiveSupport::TestCase
  test 'debug' do
    puts
    pp FakeApi::Debug.status
    assert FakeApi::Debug.status.present?
  end
end
