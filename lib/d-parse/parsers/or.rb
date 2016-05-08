module DParse
  module Parsers
    class Or < DParse::Parser
      def initialize(*parsers)
        @parsers = parsers
      end

      def read(input, pos)
        @parsers
          .lazy
          .map { |parser| parser.read(input, pos) }
          .select { |res| res.is_a?(Success) }
          .first || Failure.new(pos)
      end

      def inspect
        "or(#{@parsers.map(&:inspect).join(',')})"
      end
    end
  end
end
