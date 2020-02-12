require 'test_helper'

class FakeApi::Test < ActiveSupport::TestCase
  test 'debug' do
    FakeApi::Debug.status
  end
end
