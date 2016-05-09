module DParse
  class Failure
    attr_reader :input
    attr_reader :pos
    attr_reader :message

    def initialize(input, pos, message: '?')
      @input = input
      @pos = pos
      @message = message
    end

    def map
      self
    end

    def full_message
      "#{@message} at line #{@pos.line + 1}, column #{@pos.column + 1}"
    end

    def to_s
      "Failure(#{@pos}; #{@message})"
    end

    def success?
      false
    end

    def inspect
      to_s
    end
  end
end
