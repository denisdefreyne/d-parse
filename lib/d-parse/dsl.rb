module DParse
  module DSL
    def char(c)
      DParse::Parsers::Char.new(c)
    end

    def chars(*cs)
      DParse::Parsers::Chars.new(*cs)
    end

    def not_char(c)
      DParse::Parsers::NotChar.new(c)
    end

    def not_chars(*cs)
      DParse::Parsers::NotChars.new(*cs)
    end

    def seq(*ps)
      DParse::Parsers::Sequence.new(*ps)
    end

    def alt(*ps)
      DParse::Parsers::Alt.new(*ps)
    end

    def string(s)
      DParse::Parsers::String.new(s)
    end

    def end_of_input
      DParse::Parsers::EndOfInput.new
    end

    def lazy(&block)
      DParse::Parsers::Lazy.new(&block)
    end

    def whitespace_char
      DParse::Parsers::WhitespaceChar.new
    end
  end
end
