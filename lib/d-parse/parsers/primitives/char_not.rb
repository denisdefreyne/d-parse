# frozen_string_literal: true

module DParse
  module Parsers
    class CharNot < DParse::Parser
      def initialize(char)
        raise ArgumentError, 'Expected input to have one char' unless char.length == 1

        @char = char
      end

      def read(input, pos)
        char = input[pos.index]
        if char != @char && char
          Success.new(input, pos.advance(char))
        else
          Failure.new(input, pos, origin: self)
        end
      end

      def inspect
        "char_not(#{@char.inspect})"
      end

      def expectation_message
        "any character not equal to #{display(@char)}"
      end
    end
  end
end
