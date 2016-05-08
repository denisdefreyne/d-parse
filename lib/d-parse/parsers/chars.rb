module DParse
  module Parsers
    class Chars < DParse::Parser
      def self.new(*chars)
        chars
          .map { |c| DParse::Parsers::Char.new(c) }
          .reduce { |a, e| DParse::Parsers::Or.new(a, e) }
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
