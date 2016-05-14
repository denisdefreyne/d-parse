module DParse
  module Parsers
    class JSON < DParse::Parser
      def self.new
        extend DParse::DSL

        json_value = nil # Undefined for now

        whitespace =
          repeat(
            alt(
              char(' '),
              char("\t"),
              char("\r"),
              char("\n"),
            ),
          )

        # String

        json_digit_hex =
          alt(
            char_in('0'..'9'),
            char_in('a'..'f'),
            char_in('A'..'F'),
          )

        json_string =
          seq(
            char('"').ignore,
            repeat(
              alt(
                char_not_in(%w( " \\ )).capture,
                seq(
                  char('\\').ignore,
                  alt(
                    char_in(%w( " \\ / b f n r t )).capture,
                    seq(
                      char('u').capture,
                      seq(
                        json_digit_hex,
                        json_digit_hex,
                        json_digit_hex,
                        json_digit_hex,
                      ).capture,
                    ),
                  ),
                ).compact,
              ),
            ),
            char('"').ignore,
          ).compact.first.map do |d, _, _|
            new_chars =
              d.map do |char|
                case char
                when ::String
                  char
                when ::Array
                  case char[0]
                  when '"'
                    '"'
                  when '\\'
                    '\\'
                  when '/'
                    '/'
                  when 'b'
                    "\b"
                  when 'f'
                    "\f"
                  when 'n'
                    "\n"
                  when 'r'
                    "\r"
                  when 't'
                    "\t"
                  else
                    if char[0].is_a?(Array) && char[0][0] == 'u'
                      char[0][1].to_i(16).chr(Encoding::UTF_8)
                    else
                      raise "Unexpected escape sequence #{char[0].inspect}"
                    end
                  end
                else
                  raise "??? #{char.inspect} (#{char.class})"
                end
              end

            new_chars.join('')
          end

        # Array

        json_elements =
          intersperse(
            lazy { json_value },
            seq(
              whitespace,
              char(','),
              whitespace,
            ).ignore,
          ).compact

        json_array =
          seq(
            char('[').ignore,
            whitespace.ignore,
            json_elements,
            whitespace.ignore,
            char(']').ignore,
          ).compact.first

        # Misc

        json_true =
          string('true').map { true }

        json_false =
          string('false').map { false }

        json_null =
          string('null').map { nil }

        # Number

        json_digit =
          char_in('0'..'9')

        json_number =
          seq(
            opt(char('-')).capture,
            alt(
              char('0'),
              seq(
                char_in('1'..'9'),
                repeat(json_digit),
              ),
            ).capture,
            opt(
              seq(
                char('.').ignore,
                repeat(json_digit).capture,
              ).compact,
            ),
            opt(
              seq(
                alt(char('e'), char('E')),
                alt(char('+'), char('-'), succeed).capture,
                repeat(json_digit).capture,
              ).compact,
            ),
          ).map do |d, _, _|
            sign_char          = d[0]
            digits_before_dot  = d[1]
            digits_after_dot   = d[2]
            sci_data           = d[3]

            base =
              if digits_after_dot
                [sign_char, digits_before_dot, '.', digits_after_dot].join('').to_f
              else
                [sign_char, digits_before_dot].join('').to_i(10)
              end

            factor =
              if sci_data
                sign_char = sci_data[0]
                exponent  = sci_data[1]

                unsigned_factor = exponent.to_i(10)

                case sign_char
                when '+', ''
                  10**unsigned_factor
                when '-'
                  - 10**unsigned_factor
                end
              else
                1
              end

            base * factor
          end

        # Object

        json_pair =
          seq(
            json_string,
            whitespace.ignore,
            char(':').ignore,
            whitespace.ignore,
            lazy { json_value },
          ).compact

        json_pairs =
          intersperse(
            json_pair,
            seq(
              whitespace,
              char(','),
              whitespace,
            ).ignore,
          ).compact.map { |d| Hash[d] }

        json_object =
          seq(
            char('{').ignore,
            whitespace.ignore,
            json_pairs,
            whitespace.ignore,
            char('}').ignore,
          ).compact.first

        # Value

        json_value =
          alt(
            json_string,
            json_number,
            json_object,
            json_array,
            json_true,
            json_false,
            json_null,
          )

        # All

        json_object
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
