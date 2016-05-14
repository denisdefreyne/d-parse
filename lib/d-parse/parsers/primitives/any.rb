module DParse
  module Parsers
    class Any < DParse::Parser
      def read(input, pos)
        char = input[pos.index]
        if char
          Success.new(input, pos.advance(char))
        else
          Failure.new(input, pos)
        end
      end

      def inspect
        'any()'
      end
    end
  end
end
