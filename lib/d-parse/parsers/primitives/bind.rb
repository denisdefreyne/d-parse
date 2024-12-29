# frozen_string_literal: true

module DParse
  module Parsers
    class Bind < DParse::Parser
      def initialize(parser, &block)
        super()
        @parser = parser
        @block = block
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when Success
          other_parser = @block.call(res.data)
          other_parser.read(input, res.pos)
        when Failure
          res
        end
      end

      def inspect
        "bind(#{@parser}, <proc>)"
      end
    end
  end
end
