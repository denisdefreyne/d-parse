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

      private

      def best(a, b)
        successes, failures = [a, b].partition { |pa| pa.is_a?(DParse::Success) }

        best_success = successes.max_by { |r| r.pos.index }
        best_failure = failures.max_by { |r| r.pos.index }

        case successes.size
        when 2
          best_success
        when 1
          best_success.with_best_failure(best_failure)
        when 0
          best_failure
        end
      end
    end
  end
end
