# frozen_string_literal: true

require_relative "../combinators/alt"

module DParse
  module Parsers
    class CharIn < ::DParse::Parsers::Alt
      def initialize(chars)
        super(*chars.map { |c| DParse::Parsers::Char.new(c) })
      end
    end
  end
end
