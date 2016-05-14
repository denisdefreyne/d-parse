module DParse
  module Parsers
    class Alt < DParse::Parser
      def initialize(*parsers)
        @parsers = parsers
      end

      def read(input, pos)
        @parsers
          .lazy
          .map { |parser| parser.read(input, pos) }
          .select { |res| res.is_a?(Success) }
          .first || Failure.new(input, pos)
      end

      def inspect
        "alt(#{@parsers.map(&:inspect).join(',')})"
      end
    end
  end
end
