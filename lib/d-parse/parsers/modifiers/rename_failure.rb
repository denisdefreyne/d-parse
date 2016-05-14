module DParse
  module Parsers
    class RenameFailure < DParse::Parser
      def initialize(parser, message)
        @parser = parser
        @message = message
      end

      def read(input, pos)
        res = @parser.read(input, pos)
        case res
        when DParse::Success
          res
        when DParse::Failure
          Failure.new(res.input, res.pos, message: @message)
        end
      end

      def inspect
        "rename_failure(#{@parser})"
      end
    end
  end
end
