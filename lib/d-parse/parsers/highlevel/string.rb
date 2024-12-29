# frozen_string_literal: true

module DParse
  module Parsers
    class String < DParse::Parser
      def self.new(string)
        DParse::Parsers::Describe.new(
          DParse::Parsers::Seq.new(
            *string.chars.map { |c| DParse::Parsers::Char.new(c) },
          ),
          "string[#{string.inspect}]",
        )
      end

      def initialize(*)
        super()
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
