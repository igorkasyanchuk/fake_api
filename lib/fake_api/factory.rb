module FakeApi
  class Factory
    attr_reader :name, :value
    def initialize(name, value = nil, &block)
      @name  = name
      @value = value || block
    end

    def returns(new_value = nil, &block)
      @value = new_value || block
      self
    end
  end
end