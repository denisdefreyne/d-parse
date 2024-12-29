# frozen_string_literal: true

module DParse
  module Parsers
    class Map < DParse::Parser
      def initialize(parser, &block)
        super()
        @parser = parser
        @block = block
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when Success
          slice = StringSlice.new(string: input, from: pos, to: res.pos)
          Success.new(input, res.pos, data: @block.call(res.data, slice), best_failure: res.best_failure)
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
