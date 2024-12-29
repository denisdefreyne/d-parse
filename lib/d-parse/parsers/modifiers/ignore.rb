# frozen_string_literal: true

module DParse
  module Parsers
    class Ignore < DParse::Parser
      def initialize(parser)
        super()
        @parser = parser
      end

      def read(input, pos)
        @parser.read(input, pos).map { |_| nil }
      end

      def inspect
        "ignore(#{@parser.inspect})"
      end
    end
  end
end
