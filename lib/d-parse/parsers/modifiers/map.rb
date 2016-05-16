module DParse
  module Parsers
    class Map < DParse::Parser
      def initialize(parser, &block)
        @parser = parser
        @block = block
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when Success
          Success.new(input, res.pos, data: @block.call(res.data, res, pos), best_failure: res.best_failure)
        when Failure
          res
        end
      end

      def inspect
        "map(#{@parser}, <proc>)"
      end
    end
  end
end
