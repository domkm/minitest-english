require 'test_helper'
require 'minitest/english/deny'

describe MiniTest::Assertions do
  MiniTest::Assertions.instance_methods.each do |method|    
    next unless match = /\Arefute(.*)/.match(method)   
    it "aliases #{method} to deny#{match[1]}" do
      assert_equal MiniTest::Assertions.instance_method(method),
                   MiniTest::Assertions.instance_method("deny#{match[1]}")
    end
  end
end
