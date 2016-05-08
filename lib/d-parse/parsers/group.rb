module DParse
  module Parsers
    class Group < DParse::Parser
      def self.new(parser)
        parser.map(&:itself)
      end

      def initialize(*_args)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
