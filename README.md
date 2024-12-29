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

module Grammar
  extend DParse::DSL

  DIGIT = char_in('0'..'9')

  ROOT =
    seq(
      intersperse(
        repeat(DIGIT).capture.map { |d| d.to_i(10) },
        char(',').ignore,
      ).compact,
      eof,
    ).first
end

res = Grammar::ROOT.apply("1,2,100,582048,07,09")
case res
when DParse::Success
  p res.data
when DParse::Failure
  $stderr.puts res.pretty_message
  exit 1
end
```

## Parsers

* `alt(p1, p2, …)` attempts to apply any of the given parsers.

* `any` parses any character.

* `char(c)` parses the single character `c`.

* `char_not(c)` parses a character that is not `c`.

* `char_in(cs)` parses a character that is in the `cs` collection.

* `char_not_in(cs)` parses a character that is not in the `cs` collection.

* `eof` parses the end of file.

* `fail` always fails.

* `describe(p, name)` sets the name of the parser, so that parsing failures of `p` return a failure with message “expected _name_”.

* `repeat(p)` tries to apply `p` as many times as possible, and never fails.

* `repeat0(p)` is the same as `repeat(p)`.

* `repeat1(p)` tries to apply `p` as many times as possible, but at least once.

* `seq(p1, p2, …)` tries to apply the given parsers in sequence.

* `succeed` always succeeds, without advancing the position.

Special modifiers:

* `lazy { p }` references the parser `p`, which might not be defined yet. This is useful for recursive definitions.

* `p.capture` sets the data of the parsing result of `p`, if successful, to the data between the start and the end of the match.

* `p.ignore` sets the data of the parsing result of `p`, if successful, to `nil`. This is particularly useful in combination with `p.compact`.

* `p.map { |data| … }` sets the data of the parsing result of `p`, if successful, to the return value of the block. The block gets the data of the success as an argument.

* `p.first` sets the data of the parsing result of `p`, if successful, to the first element of the data of the success. This only works if the success data is an array.

* `p.second` sets the data of the parsing result of `p`, if successful, to the second element of the data of the success. This only works if the success data is an array.

* `p.select_odd` sets the data of the parsing result of `p`, if successful, to each odd element of the data of the success. This only works if the success data is an array.

* `p.select_even` sets the data of the parsing result of `p`, if successful, to each even element of the data of the success. This only works if the success data is an array.

* `p.compact` sets the data of the parsing result of `p`, if successful, to each non-nil element of the data of the success. This only works if the success data is an array. This is particularly useful in combination with `p.ignore`.

## To do

As mentioned above, this software is in an early state, and still lacks many features. It is not yet a fully functional parser combinator library, but it’ll hopefully get there.

* Add support for backtracking, so that `seq(repeat(any), string('donkey'))` can parse `superdonkey`.

* Add failure descriptions to all parsers.

* Allow renaming failures, so that errors can be easier to understand for hoominz.

* Add tests for everything.

* Add documentation.

* Add support for parsing generic token streams, rather than just characters.
