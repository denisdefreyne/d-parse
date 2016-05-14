[![Build status](http://img.shields.io/travis/ddfreyne/d-parse.svg)](https://travis-ci.org/ddfreyne/d-parse)
[![Code Climate](http://img.shields.io/codeclimate/github/ddfreyne/d-parse.svg)](https://codeclimate.com/github/ddfreyne/d-parse)
[![Code Coverage](http://img.shields.io/coveralls/ddfreyne/d-parse.svg)](https://coveralls.io/r/ddfreyne/d-parse)

# D★Parse

_D★Parse_ is a parser combinator library for Ruby.

**STATUS**: Experimental. Pre-alpha. Use at your own risk.

## Example

Here is a parser for a series of numbers:

```ruby
require 'd-parse'
include DParse::DSL

digit =
  char_in('0'..'9')

parser =
  seq(
    intersperse(
      repeat(digit).capture.map { |d| d.to_i(10) },
      char(',').ignore,
    ).compact,
    eof,
  ).first

res = parser.apply("1,2,100,582048,07,09")
case res
when DParse::Success
  p res.data
when DParse::Failure
  $stderr.puts res.pretty_message
  exit 1
end
```

## To do

As mentioned above, this software is in an early state, and still lacks many features. It is not yet a fully functional parser combinator library, but it’ll hopefully get there.

* Add more combinators (e.g. `repeat1`).

* Add support for backtracking, so that `seq(repeat(any), string('donkey'))` can parse `superdonkey`.

* Add failure descriptions to all parsers.

* Allow renaming failures, so that errors can be easier to understand for hoominz.

* Add tests for everything.

* Add documentation.

## Commit message conventions

As an experiment, I’m going to use commit message conventions slightly adapted from [Angular.js](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md)’s.

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
```

The following types are supported:

* `feat` (new feature)
* `fix` (bug fix)
* `docs` (documentation)
* `style` (formatting, …)
* `refactor`
* `test` (adding tests)
* `chore` (maintenance, such as build infrastructure changes)

The following scopes are supported:

* `core`
* `parsers`
* `samples`

The following rules apply to the subject:

* Use the imperative, present tense.
* Do not capitalize the first letter.
* Do not end the subject with a period.
