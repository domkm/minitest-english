require 'minitest/unit'
require 'minitest/spec'

module MiniTest
  module English
    class << self

      def register_assertion(matcher, replacement)
        matcher, block = parse!(matcher, replacement)
        register MiniTest::Assertions, matcher, &block
      end

      def register_expectation(matcher, replacement)
        matcher, block = parse!(matcher, replacement)
        register MiniTest::Expectations, matcher, &block
      end

      def register(mod, matcher, &block)
        validate! mod, matcher, &block
        REGISTRATIONS[mod][matcher] = block
        watch mod
        scan  mod
        true
      end

      private

      REGISTRATIONS = Hash.new { |hash, key| hash[key] = {} }

      def scan(mod, method = nil)
        if method
          REGISTRATIONS[mod].each do |regex, block|
            next unless match = regex.match(method)
            mod.module_exec(match, block) do
             alias_method block.(match.captures), match.to_s
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

      def parse!(matcher, replacement)
        unless matcher.count('*') == replacement.count('*')
          raise ArgumentError.new "Expected matching number of wildcards; got #{matcher}, #{replacement}"
        end
        [
          /\A#{matcher.gsub('*','(.*)')}\z/,
          proc do |captures|
            captures.each_with_object(replacement.dup) do |cap, str|
              str.sub! '*', cap
            end
          end
        ]
      end

      def validate!(mod, matcher, &block)
        unless mod.is_a? Module or mod.is_a? Class
          raise ArgumentError.new "Expected Module or Class; received: #{mod.class}"
        end
        unless matcher.is_a? Regexp
          raise ArgumentError.new "Expected Regex; received: #{matcher.class}"
        end
        unless block_given?
          raise ArgumentError.new 'Expected a block to be passed'
        end
      end

    end
  end
end
