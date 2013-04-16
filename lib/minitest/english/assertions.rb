require 'minitest/unit'

module MiniTest::Assertions
	instance_methods.each do |method|
		next unless match = /^refute(.*)/.match(method)
		alias_method "deny#{match[1]}", method
	end
end
