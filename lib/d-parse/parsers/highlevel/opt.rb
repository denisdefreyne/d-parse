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
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
