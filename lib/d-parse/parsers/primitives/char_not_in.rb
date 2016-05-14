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
          Failure.new(input, pos, message: "expected any character not in #{@chars.map { |c| display(c) }.join(', ')}, but found #{display char}")
        end
      end

      def inspect
        "not-chars(#{@char.inspect})"
      end
    end
  end
end
