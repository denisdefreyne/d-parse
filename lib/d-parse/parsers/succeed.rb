module DParse
  module Parsers
    class Succeed < DParse::Parser
      def read(input, pos)
        Success.new(input, pos)
      end

      def inspect
        'succeed()'
      end
    end
  end
end
