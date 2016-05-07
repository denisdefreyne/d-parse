module DParse
  class Parser
    def read(_input, _pos)
      raise NotImplementedError
    end

    def inspect
      raise NotImplementedError
    end

    def to_s
      inspect
    end

    def map(&block)
      DParse::Parsers::Map.new(self, &block)
    end

    def bind(&block)
      DParse::Parsers::Bind.new(self, &block)
    end

    def >>(other)
      # NOTE: overridden in Sequence
      DParse::Parsers::Sequence.new(self, other)
    end

    def |(other)
      DParse::Parsers::Or.new(self, other)
    end

    def repeat
      DParse::Parsers::Repeat.new(self)
    end

    def optional
      DParse::Parsers::Optional.new(self)
    end

    def capture
      DParse::Parsers::Capturing.new(self)
    end

    def named(name)
      DParse::Parsers::Name.new(self, name)
    end
  end
end
