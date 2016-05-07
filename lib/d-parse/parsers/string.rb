module DParse
  module Parsers
    class String < DParse::Parser
      def initialize(string)
        @string = string
      end

      def read(input, pos)
        if input[pos.index, @string.length] == @string
          Success.new(pos.advance(@string.length))
        else
          Failure.new(pos)
        end
      end

      def inspect
        "string(#{@string.inspect})"
      end
    end
  end
end
