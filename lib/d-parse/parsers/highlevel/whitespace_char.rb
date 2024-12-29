# frozen_string_literal: true

module DParse
  module Parsers
    class WhitespaceChar < DParse::Parser
      WS = [' ', "\t"].freeze

      def self.new
        DParse::Parsers::CharIn.new(WS)
      end

      def initialize(*)
        super()
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
