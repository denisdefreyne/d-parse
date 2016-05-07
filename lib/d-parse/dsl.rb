module DParse
  module DSL
    def char(c)
      DParse::Parsers::Char.new(c)
    end

    def chars(*cs)
      DParse::Parsers::Chars.new(*cs)
    end

    def end_of_input
      DParse::Parsers::EndOfInput.new
    end

    def lazy(&block)
      DParse::Parsers::Lazy.new(&block)
    end

    def whitespace
      DParse::Parsers::Whitespace.new
    end
  end
end

include DParse::DSL
