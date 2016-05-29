module DParse
  module Parsers
    class CharNotIn < DParse::Parser
      def initialize(chars)
        unless chars.all? { |char| char.length == 1 }
          raise ArgumentError, 'Expected input to have one char'
        end

        @chars = chars
      end

      def read(input, pos)
        char = input[pos.index]
        if char && @chars.all? { |c| char != c }
          Success.new(input, pos.advance(char))
        else
          Failure.new(input, pos, origin: self)
        end
      end

      def inspect
        "char_not_in(#{@chars.inspect})"
      end

      def expectation_message
        "any character not in #{@chars.map { |c| display(c) }.join(', ')}"
      end
    end
  end
end
