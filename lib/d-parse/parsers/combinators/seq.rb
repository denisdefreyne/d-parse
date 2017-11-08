# frozen_string_literal: true

module DParse
  module Parsers
    class Seq < DParse::Parser
      attr_reader :parsers

      def initialize(*parsers)
        @parsers = parsers
      end

      def read(input, pos)
        @parsers.reduce(Success.new(input, pos, data: [])) do |res, parser|
          case res
          when Success
            new_res = parser.read(input, res.pos).map { |d| res.data + [d] }
            with_best_failure(new_res, res)
          when Failure
            res
          end
        end
      end

      def inspect
        "seq(#{@parsers.map(&:inspect).join(',')})"
      end

      private

      # Returns a Success or Failure that most accurately describes the
      # failure, meaning the result that has the highest position.
      def with_best_failure(new_res, res)
        results = [new_res, res]
        results += [new_res.best_failure] if new_res.is_a?(Success)
        results += [res.best_failure] if res.is_a?(Success)

        best_failure =
          results
          .select { |r| r.is_a?(DParse::Failure) }
          .max_by { |r| r.pos.index }

        case new_res
        when Success
          new_res.with_best_failure(best_failure)
        when Failure
          best_failure
        end
      end
    end
  end
end
