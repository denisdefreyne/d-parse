module DParse
  module Parsers
    class Intersperse < DParse::Parser
      def self.new(a, b)
        DParse::Parsers::Sequence.new(
          a,
          DParse::Parsers::Sequence.new(b, a).repeat.flatten.map { |d| d || [] },
        ).map { |d| [d[0]] + d[1] }
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
