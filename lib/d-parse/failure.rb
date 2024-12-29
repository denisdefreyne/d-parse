# frozen_string_literal: true

module DParse
  class Failure
    attr_reader :input, :pos, :origin

    def initialize(input, pos, origin: nil)
      @input = input
      @pos = pos
      @origin = origin
    end

    def map
      self
    end

    def message
      @_message ||= "expected #{@origin ? @origin.expectation_message : '?'}"
    end

    def full_message
      "#{message} at line #{@pos.line + 1}, column #{@pos.column + 1}"
    end

    def pretty_message
      line = (input.lines[@pos.line] || '').rstrip
      fancy_line = line.chars.map.with_index { |c, i| i == @pos.column ? "\e[31m#{c}\e[0m" : c }.join

      lines = [full_message, '', fancy_line, "\e[31m#{' ' * @pos.column}↑\e[0m"]

      lines.join("\n")
    end

    def to_s
      "Failure(#{@pos}; #{message})"
    end

    def success?
      false
    end

    def inspect
      to_s
    end
  end
end
