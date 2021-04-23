# frozen_string_literal: true

module DParse
  class StringSlice
    attr_reader :string, :from, :to

    def initialize(string: 0, from: 0, to: 0)
      @string = string
      @from = from
      @to = to
    end

    def resolve
      @string[@from.index...@to.index]
    end

    def inspect
      "StringSlice(#{@from}..#{@to})"
    end
  end
end
