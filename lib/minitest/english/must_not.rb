require 'minitest/english'

MiniTest::English.register_expectation /^wont(.*)/ do |captures|
  :"must_not#{captures[0]}"
end
