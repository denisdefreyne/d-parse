# frozen_string_literal: true

module DParse
  module Parsers
    class Lazy < DParse::Parser
      def initialize(&block)
        raise ArgumentError, 'Expected block' unless block_given?
        @block = block
      end

      def read(input, pos)
        @block.call.read(input, pos)
      end

      def inspect
        'lazy(?)'
      end
    end
  end
end
