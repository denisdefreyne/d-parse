# frozen_string_literal: true

require_relative "../highlevel/char_in"

module DParse
  module Parsers
    class WhitespaceChar < DParse::Parsers::CharIn
      WS = [' ', "\t"].freeze

      def initialize(*)
        super(WS)
      end
    end
  end
end
