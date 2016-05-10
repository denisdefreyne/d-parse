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

    def pretty_message
      line = input.lines[@pos.line]
      fancy_line = line.chars.map.with_index { |c, i| i == @pos.column ? "\e[31m" + c + "\e[0m" : c }.join

      lines = [full_message, '', fancy_line, "\e[31m" + ' ' * @pos.column + '↑' + "\e[0m"]

      lines.map { |l| "\e[34m[D*Parse]\e[0m #{l.strip}\n" }.join('')
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
