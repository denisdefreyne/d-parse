# frozen_string_literal: true

module DParse
  module Parsers
    class Intersperse < DParse::Parser
      def self.new(a, b)
        DParse::Parsers::Seq.new(
          a,
          DParse::Parsers::Repeat.new(
            DParse::Parsers::Seq.new(b, a),
          ).flatten.map { |d| d || [] },
        ).map { |d| [d[0]] + d[1] }
      end

      def initialize(*)
        super()
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
