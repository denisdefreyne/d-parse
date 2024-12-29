# frozen_string_literal: true

require_relative "../combinators/alt"

module DParse
  module Parsers
    class Opt < DParse::Parsers::Alt
      def initialize(parser)
        super(
          parser,
          DParse::Parsers::Succeed.new,
        )
      end
    end
  end
end
