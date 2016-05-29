module DParse
  module Parsers
    class Except < DParse::Parser
      def initialize(parser, bad_parser)
        @parser = parser
        @bad_parser = bad_parser
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when Success
          bad_res = @bad_parser.read(input, pos)
          if bad_res.is_a?(Success) && bad_res.pos.index == res.pos.index
            Failure.new(input, pos, origin: self)
          else
            res
          end
        when Failure
          res
        end
      end

      def inspect
        "except(#{@parser.inspect}, #{@bad_parser.inspect})"
      end

      def expectation_message
        @parser.expectation_message + ', not ' + @bad_parser.expectation_message
      end
    end
  end
end
