# frozen_string_literal: true

module DParse
  module Parsers
    class Describe < DParse::Parser
      def initialize(parser, name)
        super()
        @parser = parser
        @name = name
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when DParse::Success
          res
        when DParse::Failure
          Failure.new(res.input, res.pos, origin: self)
        end
      end

      def inspect
        "#{@name}()"
      end

      def expectation_message
        @name
      end
    end
  end
end
