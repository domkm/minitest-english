require 'minitest/spec'

module MiniTest::Expectations
	instance_methods.each do |method|
	  next unless match = /^wont(.*)/.match(method)
	  alias_method "must_not#{match[1]}", method
	end
end
