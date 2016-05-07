module DParse
  module Parsers
    class Or < DParse::Parser
      def initialize(*parsers)
        @parsers = parsers
      end

      def read(input, pos)
        @parsers.each do |parser|
          res = parser.read(input, pos)
          case res
          when Success
            return res
          when Failure
          end
        end
        Failure.new(pos)
      end

      def inspect
        "or(#{@parsers.map(&:inspect).join(',')})"
      end
    end
  end
end
