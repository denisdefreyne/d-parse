module DParse
  class Parser
    def apply(input)
      # FIXME: convert input to chars first
      read(input, DParse::Position.new)
    end

    def read(_input, _pos)
      raise NotImplementedError
    end

    def inspect
      raise NotImplementedError
    end

    def to_s
      inspect
    end

    def first
      map { |d| d[0] }
    end

    def second
      map { |d| d[1] }
    end

    def select_odd
      map { |d| d.select.with_index { |_, i| i.odd? } }
    end

    def select_even
      map { |d| d.select.with_index { |_, i| i.even? } }
    end

    def flatten
      map { |d| d.is_a?(Array) ? d.reduce(:+) : d }
    end

    def map(&block)
      DParse::Parsers::Map.new(self, &block)
    end

    def bind(&block)
      DParse::Parsers::Bind.new(self, &block)
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

    def intersperse(other)
      DParse::Parsers::Intersperse.new(self, other)
    end

    def named(name)
      DParse::Parsers::Name.new(self, name)
    end

    private

    def display(char)
      char ? char.inspect.gsub(/^"|"$/, '\'') : 'end of input'
    end
  end
end
