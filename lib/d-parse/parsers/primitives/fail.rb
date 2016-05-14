module DParse
  module Parsers
    class Fail < DParse::Parser
      def read(input, pos)
        Failure.new(input, pos)
      end

      def inspect
        'failure()'
      end
    end
  end
end
