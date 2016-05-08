module DParse
  module Parsers
    class Capturing < DParse::Parser
      def self.new(parser)
        parser.map { |_, input, new_pos, old_pos| input[old_pos.index...new_pos.index] }
      end

      def initialize(*)
        raise ArgumentError, "#{self.class} is not supposed to be initialized"
      end
    end
  end
end
