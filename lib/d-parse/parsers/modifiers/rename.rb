module DParse
  module Parsers
    class Rename < DParse::Parser
      def initialize(parser, name)
        @parser = parser
        @name = name
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when DParse::Success
          res
        when DParse::Failure
          Failure.new(res.input, res.pos, message: "expected #{@name}")
        end
      end

      def inspect
        "#{@name}()"
      end
    end
  end
end
