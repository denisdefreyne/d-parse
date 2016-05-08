module DParse
  module Parsers
    class WhitespaceChar < DParse::Parser
      WS = [' ', "\t"].freeze

      def self.new
        DParse::Parsers::Chars.new(*WS)
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
