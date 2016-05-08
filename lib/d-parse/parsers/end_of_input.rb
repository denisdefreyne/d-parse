module DParse
  module Parsers
    class EndOfInput < DParse::Parser
      def read(input, pos)
        if input.size == pos.index
          Success.new(input, pos)
        else
          Failure.new(input, pos)
        end
      end

      def inspect
        'eof()'
      end
    end
  end
end
