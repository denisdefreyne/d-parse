module DParse
  module Parsers
    class EOF < DParse::Parser
      def read(input, pos)
        if input.size == pos.index
          Success.new(input, pos)
        else
          Failure.new(input, pos, origin: self)
        end
      end

      def inspect
        'eof()'
      end

      def expectation_message
        'end of input'
      end
    end
  end
end
