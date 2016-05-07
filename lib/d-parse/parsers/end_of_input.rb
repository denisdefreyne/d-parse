module DParse
  module Parsers
    class EndOfInput < DParse::Parser
      def read(input, pos)
        if input.size == pos.index
          Success.new(pos)
        else
          Failure.new(pos)
        end
      end

      def inspect
        'eof()'
      end
    end
  end
end
