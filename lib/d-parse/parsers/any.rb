module DParse
  module Parsers
    class Any < DParse::Parser
      def read(input, pos)
        if input[pos.index]
          Success.new(pos.advance)
        else
          Failure.new(pos)
        end
      end

      def inspect
        'any()'
      end
    end
  end
end
