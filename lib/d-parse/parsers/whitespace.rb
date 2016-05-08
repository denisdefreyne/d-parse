module DParse
  module Parsers
    class Whitespace < DParse::Parser
      WS = [' ', "\t"].freeze

      def read(input, pos)
        loop do
          break unless WS.include?(input[pos.index])
          pos = pos.advance
        end

        Success.new(input, pos)
      end
    end
  end
end
