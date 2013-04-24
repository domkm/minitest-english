# minitest-english [![Gem Version](https://badge.fury.io/rb/minitest-english.png)](https://rubygems.org/gems/minitest-english) [![Build Status](https://travis-ci.org/DomKM/minitest-english.png?branch=master)](https://travis-ci.org/DomKM/minitest-english)

[MiniTest](https://github.com/seattlerb/minitest) is an awesome testing framework. It's small, fast, and has very little magic.

> There are two hard things in Computer Science: cache invalidation and naming things.
> — Phil Karlton

Unfortunately, MiniTest fails at the latter. 

![Pulp Fiction](pulp_fiction.gif)

## What?

`minitest-english` provides a simple interface for defining aliases in MiniTest assertions, expectations, and other modules/classes. It also optionally augments MiniTest's default assertion and expectation naming with semantically symmetric aliases.

## Why?
 
### Assertions

MiniTest provides a variety of positive and negative assertions:

```ruby
assert_equals true, true
refute_equals true, false
assert_nil nil
refute_nil true
# etc.
```

__"Refute" is not an antonym of "assert." Refutation requires proof, not just assertion.__

### Expectations

Every assertion has an aliased expectation:

```ruby
true.must_equal true
true.wont_equal false
nil.must_be_nil
true.wont_be_nil
# etc.
```

__"Must" is present tense but "wont" (contraction of "will not") is future tense.__

## How?

`minitest-english` provides an interface for watching and aliasing methods in MiniTest::Assertions, MiniTest::Expectations, and other modules. Once a module/class and aliasing rule is registered with `MiniTest::English`, all current and future methods in the module/class that match the rule will be aliased according to that rule.

`minitest-english` also _optionally_ aliases all `refute` assertions with `deny` assertions and all `wont` expectations with `must_not` expectations.

It's simple and does not use `method_missing` or any other inefficient techniques.


## Installation

Add this line to your application's Gemfile:

    gem 'minitest-english'

And then execute:

    $ bundle install

Require it in your test_helper or spec_helper:

    require 'minitest/english'
    
To alias all `refute*` assertions to `deny*` assertions:

    require 'minitest/english/deny'

To alias all `wont*` expectations to `must_not*` expectations:

    require 'minitest/english/must_not'

## Usage

### Registering assertions and expectations

The basic format is:

    MiniTest::English.register_assertion/expectation, matcher_string, replacement_string
    
Let's register an expectation:

```ruby
MiniTest::English.register_expectation "wont*", "must_not*"
```
    
That will alias all expectations that begin with `wont` to ones that begin with `must_not`. `register_assertion` works the same way.

### Advanced registrations

`MiniTest::English`'s `register_assertion` and `register_expectation` methods are just sugar that transform their input and send it to `MinTest::English.register`. 

`MiniTest::English.register` takes a module/class, a regex that matches undesirable methods and captures the desirable parts of those methods, and a block that receives the captures and returns a symbol/string of the new method name.
These two methods produce the same result:

```ruby
MiniTest::English.register_expectation "wont*", "must_not*"
```

```ruby
MiniTest::English.register MiniTest::Expectations, /\Awont(.*)\z/ do |captures|
  :"must_not#{captures[0]}"
end
```

`MiniTest::English.register` is provided as a more flexible but verbose interface to deal with other classes/modules and other edge cases.

### deny & must_not

##### minitest/english/deny
Write your negative assertions with `deny`.
```ruby
require 'minitest/english/deny'
refute_equal "English", "Do you speak it?"
# refute* becomes deny*
deny_equal "English", "Do you speak it?"
```

##### minitest/english/must_not
Write your negative expectations with `must_not`.
```ruby
require 'minitest/english/must_not
"Do you speak it?".wont_equal "English"
# wont* becomes must_not*
"Do you speak it?".must_not_equal "English"
```

## Caveat

Perhaps you prefer geometric equality to semantic equality. 

```ruby
"assert".length == "refute".length
"must".length == "wont".length
```

If so, use `minitest-english` anyway and make your middle school English teacher proud.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
