require 'd-parse'

module Grammar
  extend DParse::DSL

  # primitives

  DIGIT = char_in('0'..'9')
  LETTER = char_in('a'..'z')
  LPAREN = char('(')
  RPARE = char(')')
  COMMA = char(',')
  SEMICOLON = char(';')
  LBRACE = char('{')
  RBRACE = char('}')

  # basic

  IDENTIFIER =
    rename_failure(
      seq(
        LETTER,
        repeat(LETTER),
      ).capture,
      'expected identifier',
    )

  INTEGER =
    seq(
      DIGIT,
      repeat(DIGIT),
    ).capture.map { |d| [:int, d.to_i(10)] }

  VAR =
    IDENTIFIER.map { |d| [:var, d] }

  EOF =
    seq(
      opt(char("\n")),
      eof,
    )

  WHITESPACE_CHAR =
    alt(
      char(' '),
      char("\t"),
      char("\n"),
      char("\r"),
    )

  WHITESPACE0 =
    repeat(WHITESPACE_CHAR)

  WHITESPACE1 =
    seq(WHITESPACE_CHAR, WHITESPACE0)

  # complex

  FUNDEF_ARGLIST_TAIL =
    repeat(
      seq(
        COMMA,
        WHITESPACE0,
        VAR,
      ).map { |d| d[2] },
    )

  FUNDEF_ARGLIST =
    alt(
      seq(
        VAR,
        FUNDEF_ARGLIST_TAIL,
      ).map { |d| [d[0]] + d[1] },
      succeed.map { [] },
    )

  FUNDEF =
    seq(
      string('def').ignore,
      WHITESPACE1.ignore,
      IDENTIFIER,
      LPAREN.ignore,
      FUNDEF_ARGLIST,
      RPARE.ignore,
      WHITESPACE1.ignore,
      LBRACE.ignore,
      WHITESPACE0.ignore,
      repeat(lazy { STATEMENT }),
      WHITESPACE0.ignore,
      RBRACE.ignore,
    ).compact.map { |d| [:def] + d }

  EXPRESSION =
    alt(
      lazy { FUNCALL },
      INTEGER,
      VAR,
    )

  ARGLIST_TAIL =
    repeat(
      seq(
        COMMA,
        WHITESPACE0,
        EXPRESSION,
      ).map { |d| d[2] },
    )

  ARGLIST =
    alt(
      seq(
        EXPRESSION,
        ARGLIST_TAIL,
      ).map { |d| [d[0]] + d[1] },
      succeed.map { [] },
    )

  FUNCALL =
    seq(
      IDENTIFIER,
      LPAREN,
      ARGLIST,
      RPARE,
    ).map { |d| [:call, d[0]] + d[2] }

  STATEMENT =
    alt(
      FUNDEF,
      seq(
        EXPRESSION,
        SEMICOLON.ignore,
        WHITESPACE0.ignore,
      ).compact.first,
    )

  PROGRAM =
    seq(
      intersperse(
        STATEMENT,
        WHITESPACE0.ignore,
      ).compact,
      EOF.ignore,
    ).compact.first
end
