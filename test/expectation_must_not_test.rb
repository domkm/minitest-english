require 'test_helper'
require 'minitest/english/must_not'

describe MiniTest::Expectations do
  MiniTest::Expectations.instance_methods.each do |method|
    next unless match = /\Awont(.*)/.match(method)
    it "aliases #{method} to must_not#{match[1]}" do
      assert_equal MiniTest::Expectations.instance_method(method),
                   MiniTest::Expectations.instance_method("must_not#{match[1]}")
    end
  end
end
