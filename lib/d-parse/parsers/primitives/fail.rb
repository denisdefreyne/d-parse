# frozen_string_literal: true

module DParse
  module Parsers
    class Fail < DParse::Parser
      def read(input, pos)
        Failure.new(input, pos, origin: self)
      end

      def inspect
        'fail()'
      end

      def expectation_message
        'nothing (always fail)'
      end
    end
  end
end
