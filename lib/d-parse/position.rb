module DParse
  class Position
    attr_reader :index

    def initialize(index: 0, line: 0, column: 0)
      @index = index
      @line = line
      @column = column
    end

    def advance_line
      Position.new(index: @index + 1, line: @line + 1, column: 0)
    end

    def advance(n = 1)
      Position.new(index: @index + n, line: @line, column: @column + n)
    end

    def to_s
      "Pos(#{@index}; #{@line}:#{@column})"
    end

    def inspect
      to_s
    end
  end
end
