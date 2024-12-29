# frozen_string_literal: true

module DParse
  class Success
    attr_reader :input, :pos, :data, :best_failure

    def initialize(input, pos, data: nil, best_failure: nil)
      @input = input
      @pos = pos
      @data = data
      @best_failure = best_failure
    end

    def map
      self.class.new(@input, @pos, data: yield(@data), best_failure: @best_failure)
    end

    def with_best_failure(failure)
      self.class.new(@input, @pos, data: @data, best_failure: failure)
    end

    def to_s
      "Success(#{@pos}; #{@data}#{@best_failure ? '; best failure = ' + best_failure.inspect : ''})"
    end

    def success?
      true
    end

    def inspect
      to_s
    end
  end
end
