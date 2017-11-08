# frozen_string_literal: true

module DParse
  module Parsers
    class Repeat < DParse::Parser
      def initialize(parser)
        @parser = parser
      end

      def read(input, pos)
        prev_res = Success.new(input, pos, data: [])
        best_failure = nil

        loop do
          new_res = @parser.read(input, prev_res.pos)
          best_failure = find_best_failure(best_failure, new_res)

          if prev_res.pos.index == new_res.pos.index
            return prev_res.with_best_failure(best_failure)
          end

          case new_res
          when Success
            prev_res = new_res.map { |d| prev_res.data + [d] }
          else
            return prev_res.with_best_failure(best_failure)
          end
        end
      end

      def inspect
        "repeat(#{@parser})"
      end

      private

      def find_best_failure(*results)
        results
          .select { |r| r.is_a?(DParse::Failure) }
          .max_by { |r| r.pos.index }
      end
    end
  end
end
