module DParse
  module Parsers
    class Any < DParse::Parser
      def read(input, pos)
        char = input[pos.index]
        if char
          Success.new(input, pos.advance(char))
        else
          Failure.new(input, pos, origin: self)
        end
      end

      def inspect
        'any()'
      end

      def expectation_message
        'any character (not end of file)'
      end
    end
  end
end
