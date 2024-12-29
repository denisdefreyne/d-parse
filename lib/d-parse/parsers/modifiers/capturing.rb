# frozen_string_literal: true

module DParse
  module Parsers
    class Capturing < DParse::Parser
      def self.new(parser)
        parser.map { |_data, slice| slice.resolve }
      end

      def initialize(*)
        super()
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
