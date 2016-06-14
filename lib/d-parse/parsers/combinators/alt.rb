module DParse
  module Parsers
    class Alt < DParse::Parser
      def initialize(*parsers)
        # FIXME: ensure >0 parsers are provided
        @parsers = parsers
      end

      def read(input, pos)
        init = DParse::Failure.new(input, DParse::Position::FAR_BEHIND)
        @parsers.reduce(init) do |old_res, parser|
          case old_res
          when DParse::Success
            old_res
          when DParse::Failure
            new_res = parser.read(input, pos)
            case new_res
            when DParse::Success
              new_res.with_best_failure(old_res)
            when DParse::Failure
              [old_res, new_res].max_by { |r| r.pos.index }
            end
          end
        end
      end

      def inspect
        "alt(#{@parsers.map(&:inspect).join(',')})"
      end
    end
  end
end
