module DParse
  module Parsers
    class Intersperse < DParse::Parser
      def initialize(a, b)
        @a = a
        @b = b

        @parser =
          SequenceParser.new(
            a,
            RepeatParser.new(
              SequenceParser.new(
                b,
                a,
              ).map { |d| d[0] },
            ),
          ).map { |d| d[1] ? [d[0]] + d[1] : d }
      end

      def read(input, pos)
        @parser.read(input, pos)
      end

      def inspect
        "intersperse(#{@a.inspect}, #{@b.inspect})"
      end
    end
  end
end
