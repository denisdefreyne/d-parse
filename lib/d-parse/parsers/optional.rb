module DParse
  module Parsers
    class Optional < DParse::Parser
      def initialize(parser)
        @parser = parser
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when Success
          res
        when Failure
          Success.new(pos)
        end
      end
    end
  end
end
