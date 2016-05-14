module DParse
  class Position
    attr_reader :index
    attr_reader :line
    attr_reader :column

    def initialize(index: 0, line: 0, column: 0)
      @index = index
      @line = line
      @column = column
    end

    def advance(char)
      Position.new(
        index: @index + 1,
        line: char == "\n" ? @line + 1 : @line,
        column: char == "\n" ? 0 : @column + 1,
      )
    end

    def to_s
      "line #{@line + 1}, column #{@column + 1}"
    end

    def inspect
      "Pos(#{@index}; #{@line}:#{@column})"
    end
  end
end
