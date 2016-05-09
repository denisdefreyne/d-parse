module DParse
  module Parsers
    class Char < DParse::Parser
      def initialize(char)
        raise ArgumentError, 'Expected input to have one char' unless char.length == 1
        @char = char
      end

      def read(input, pos)
        if input[pos.index] == @char
          Success.new(input, pos.advance)
        else
          Failure.new(input, pos, message: "expected #{display @char}, but found #{display input[pos.index]} at #{pos}")
        end
      end

      def inspect
        "char(#{@char.inspect})"
      end

      private

      def display(char)
        char ? char.inspect.gsub(/^"|"$/, '\'') : 'end of input'
      end
    end
  end
end
