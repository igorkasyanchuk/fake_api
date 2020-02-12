module FakeApi
  class Base
    mattr_accessor :data
    @@data = FakeApiData.instance
    class << self
      delegate_missing_to :data
    end
  end
  Routing   = Base
  Factoring = Base
end