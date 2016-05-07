module DParse
  module Parsers
    class Capturing < DParse::Parser
      def initialize(parser)
        @parser = parser
      end

      def read(input, pos)
        res_a = @parser.read(input, pos)
        case res_a
        when Success
          Success.new(res_a.pos, data: input[pos.index...res_a.pos.index])
        else
          res_a
        end
      end

      def inspect
        "capture(#{@parser})"
      end
    end
  end
end
