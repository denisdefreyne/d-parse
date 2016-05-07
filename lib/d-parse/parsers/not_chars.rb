module DParse
  module Parsers
    class NotChars < DParse::Parser
      def initialize(*chars)
        unless chars.all? { |char| char.length == 1 }
          raise ArgumentError, 'Expected input to have one char'
        end

        @chars = chars
      end

      def read(input, pos)
        if input[pos.index] && @chars.all? { |char| input[pos.index] != char }
          Success.new(pos.advance)
        else
          Failure.new(pos)
        end
      end

      def inspect
        "not-chars(#{@char.inspect})"
      end
    end
  end
end
