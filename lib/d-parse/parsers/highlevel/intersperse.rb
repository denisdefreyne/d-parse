# frozen_string_literal: true

require_relative "../modifiers/map"

module DParse
  module Parsers
    class Intersperse < DParse::Parsers::Map
      def initialize(a, b)
        super(
          DParse::Parsers::Seq.new(
            a,
            DParse::Parsers::Repeat.new(
              DParse::Parsers::Seq.new(b, a),
            ).flatten.map { |d| d || [] },
          )
        ) { |d| [d[0]] + d[1] }
      end
    end
  end
end
