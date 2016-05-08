module DParse
  module Parsers
    class Group < DParse::Parser
      def self.new(parser)
        parser.map { |a| a }
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
