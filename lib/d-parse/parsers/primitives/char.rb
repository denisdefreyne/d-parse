module DParse
  module Parsers
    class Char < DParse::Parser
      def initialize(char)
        raise ArgumentError, 'Expected input to have one char' unless char.length == 1
        @char = char
      end

      def read(input, pos)
        char = input[pos.index]
        if char == @char
          Success.new(input, pos.advance(char))
        else
          Failure.new(input, pos, message: "expected #{display @char}, but found #{display char}")
        end
      end

      def inspect
        "char(#{@char.inspect})"
      end
    end
  end
end
