require 'test_helper'

describe MiniTest::English do

  before do
    @module = Module.new { def pre_reg; end }
  end

  describe 'before registration' do

    it 'does not create aliases' do
      @module.method_defined?(:post_reg).must_equal false
    end

  end

  describe 'after registration' do

    before do
      MiniTest::English.register @module, /^pre(.*)/ do |captures|
        :"post#{captures[0]}"
      end
    end

    it 'creates aliases upon registration' do
      @module.method_defined?(:post_reg).must_equal true
    end

    it 'creates aliases upon method addition' do
      @module.module_exec { def pre_add; end }
      @module.method_defined?(:post_add).must_equal true
    end

  end

end
