module DParse
  module Parsers
    class Repeat < DParse::Parser
      def initialize(parser)
        @parser = parser
      end

      def read(input, pos)
        prev_res = Success.new(pos)
        loop do
          new_res = @parser.read(input, prev_res.pos)

          return prev_res if prev_res.pos.index == new_res.pos.index

          case new_res
          when Success
            prev_res = new_res.map { |d| prev_res.data + [d] }
          else
            return prev_res
          end
        end
      end

      def inspect
        "repeat(#{@parser})"
      end
    end
  end
end
