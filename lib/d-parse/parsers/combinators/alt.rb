module DParse
  module Parsers
    class Alt < DParse::Parser
      def initialize(*parsers)
        # FIXME: ensure >0 parsers are provided
        @parsers = parsers
      end

      def read(input, pos)
        @parsers
          .map { |parser| parser.read(input, pos) }
          .reduce { |a, e| best(a, e) }
      end

      def inspect
        "alt(#{@parsers.map(&:inspect).join(',')})"
      end

      def best(a, b)
        case a
        when DParse::Success
          a
        when DParse::Failure
          case b
          when DParse::Success
            b
          when DParse::Failure
            if a.pos.index > b.pos.index
              a
            else
              b
            end
          end
        end
      end
    end
  end
end
