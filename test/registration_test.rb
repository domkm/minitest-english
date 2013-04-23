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
      MiniTest::English.register @module, /\Apre(.*)\z/, 'post*'
    end
    it 'creates aliases upon registration' do
      @module.method_defined?(:post_reg).must_equal true
    end
    it 'creates aliases upon method addition' do
      @module.module_exec { def pre_add; end }
      @module.method_defined?(:post_add).must_equal true
    end
  end

  describe 'invalid registration' do
    it 'raises ArgumentError' do
      assert_raises(ArgumentError) do
        MiniTest::English.register @module, /pre(.*)/
      end
    end
  end

  describe 'custom block' do
    it 'passes regex captures and assigns method alias' do
      MiniTest::English.register @module, /(.*)reg(.*)/ do |captures|
        :"#{captures.first}foo"
      end
      @module.method_defined?(:pre_foo).must_equal true
    end
  end

end
