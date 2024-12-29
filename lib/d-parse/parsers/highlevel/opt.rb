# frozen_string_literal: true

module DParse
  module Parsers
    class Opt < DParse::Parser
      def self.new(parser)
        DParse::Parsers::Alt.new(
          parser,
          DParse::Parsers::Succeed.new,
        )
      end

      def initialize(*)
        super()
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
