# frozen_string_literal: true

require_relative "../modifiers/describe"

module DParse
  module Parsers
    class String < DParse::Parsers::Describe
      def initialize(string)
        super(
          DParse::Parsers::Seq.new(
            *string.chars.map { |c| DParse::Parsers::Char.new(c) },
          ),
          "string[#{string.inspect}]",
        )
      end
    end
  end
end
