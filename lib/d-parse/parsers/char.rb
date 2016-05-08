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
          Failure.new(input, pos)
        end
      end

      def inspect
        "char(#{@char.inspect})"
      end
    end
  end
end
