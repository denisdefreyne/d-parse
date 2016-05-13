[![Build status](http://img.shields.io/travis/ddfreyne/d-parse.svg)](https://travis-ci.org/ddfreyne/d-parse)
[![Code Climate](http://img.shields.io/codeclimate/github/ddfreyne/d-parse.svg)](https://codeclimate.com/github/ddfreyne/d-parse)
[![Code Coverage](http://img.shields.io/coveralls/ddfreyne/d-parse.svg)](https://coveralls.io/r/ddfreyne/d-parse)

# D★Parse

_D★Parse_ is a parser combinator library for Ruby.

**STATUS**: Experimental. Pre-alpha. Use at your own risk.

## To do

As mentioned above, this software is in an early state, and still lacks many features. It is not yet a fully functional parser combinator library, but it’ll hopefully get there.

* Add more combinators (e.g. `repeat1`).

* Add support for backtracking, so that `seq(repeat(any), string('donkey'))` can parse `superdonkey`.

* Add failure descriptions to all parsers.

* Allow renaming failures, so that errors can be easier to understand for hoominz.

* Add tests for everything.

* Add documentation.
