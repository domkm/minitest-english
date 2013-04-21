require 'minitest/unit'
require 'minitest/spec'

module MiniTest
  module English
    class << self

      def register_assertion(regex, &block)
        register MiniTest::Assertions, regex, &block
      end

      def register_expectation(regex, &block)
        register MiniTest::Expectations, regex, &block
      end

      def register(mod, regex, &block)
        watch mod
        REGISTRATIONS[mod][regex] = block
        scan mod
        true
      end

      private

      REGISTRATIONS = Hash.new { |hash, key| hash[key] = {} }

      def scan(mod, method = nil)
        if method
          REGISTRATIONS[mod].each do |regex, block|
            next unless match = regex.match(method)
            mod.module_exec(match, block) do |match, block|
              alias_method block.call(match.captures), match.to_s
            end
          end
        else
          mod.instance_methods.each do |method|
            scan mod, method
          end
        end
      end

      # If only Ruby 1.9 had Module#prepend...
      # Instead, we have to use this ugly thing. 
      def watch(mod)
        return if mod.respond_to? :minitest_english_method_added
        class << mod
          alias_method :minitest_english_method_added, :method_added
          def method_added(method)
            MiniTest::English.send :scan, self, method
            minitest_english_method_added method
          end
        end
      end

    end
  end
end
