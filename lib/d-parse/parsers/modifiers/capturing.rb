# frozen_string_literal: true

module DParse
  module Parsers
    class Capturing < DParse::Parser
      def self.new(parser)
        parser.map { |_data, result, old_pos| result.input[old_pos.index...result.pos.index] }
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
