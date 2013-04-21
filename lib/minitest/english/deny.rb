require 'minitest/english'

MiniTest::English.register_assertion /^refute(.*)/ do |captures|
  :"deny#{captures[0]}"
end
