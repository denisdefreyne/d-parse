module DParse
  module Parsers
    class Fail < DParse::Parser
      def read(input, pos)
        Failure.new(input, pos)
      end

      def inspect
        'fail()'
      end
    end
  end
end
