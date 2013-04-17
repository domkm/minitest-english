# minitest-english [![Gem Version](https://badge.fury.io/rb/minitest-english.png)](https://rubygems.org/gems/minitest-english) [![Build Status](https://travis-ci.org/DomKM/minitest-english.png)](https://travis-ci.org/DomKM/minitest-english)

MiniTest is an awesome testing framework. It's small, fast, and has very little magic.

> There are two hard things in Computer Science: cache invalidation and naming things.
> — Phil Karlton

Unfortunately, MiniTest fails at the latter. 

![Pulp Fiction](pulp_fiction.gif)

## What?

`minitest-english` augments MiniTest's assertion and expectation naming with semantically symmetric aliases.

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

`minitest-english` aliases all `refute` assertions with `deny` assertions and all `wont` expectations with `must_not` expectations.

It's simple and does not use `method_missing` or any other inefficient techniques.

_You know it's a tiny gem when you spend longer writing the readme than the code._


## Installation

Add this line to your application's Gemfile:

    gem 'minitest-english'

And then execute:

    $ bundle install

Require it in your test_helper or spec_helper:

    require 'minitest/english'

## Usage

Write your negative assertions with `deny`.
```ruby
refute_equal "English", "Do you speak it?"
# refute* becomes deny*
deny_equal "English", "Do you speak it?"
```

Write your negative expectations with `must_not`.
```ruby
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
