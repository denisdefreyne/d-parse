module DParse
  module Parsers
    class Name < DParse::Parser
      def initialize(parser, name)
        @parser = parser
        @name = name
      end

      def read(input, pos)
        @parser.read(input, pos)
      end

      def inspect
        "name(#{@name})"
      end
    end
  end
end
