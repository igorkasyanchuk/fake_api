module FakeApi

  class BaseStuct < OpenStruct
    def initialize(name, value)
      super(name: name, value: value)
    end
  end
  Response = BaseStuct
  Route    = BaseStuct

  class Base
    mattr_accessor :data
    @@data = FakeApiData.instance

    class << self
      delegate_missing_to :data
    end
  end
  Routing = Base
  Factory = Base

end