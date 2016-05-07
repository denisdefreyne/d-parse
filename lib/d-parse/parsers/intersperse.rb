module DParse
  module Parsers
    class Intersperse < DParse::Parser
      def self.new(a, b)
        (
          a >>
          (b >> a).repeat.flatten
        ).map { |d| [d[0]] + d[1] }
      end

      def initialize(*_args)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
