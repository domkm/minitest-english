require 'minitest/english'

MiniTest::English.register_expectation /\Awont(.*)\z/, 'must_not*'
