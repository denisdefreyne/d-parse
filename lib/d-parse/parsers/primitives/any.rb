module DParse
  module Parsers
    class Any < DParse::Parser
      def read(input, pos)
        if input[pos.index]
          Success.new(input, pos.advance)
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
