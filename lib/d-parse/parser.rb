module DParse
  class Parser
    def apply(input)
      # FIXME: convert input to chars first
      read(input, DParse::Position.new)
    end

    def read(_input, _pos)
      raise NotImplementedError
    end

    def expectation_message
      '?'
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

    def compact
      map { |d, _, _| d.compact }
    end

    def map(&block)
      DParse::Parsers::Map.new(self, &block)
    end

    def ignore
      DParse::Parsers::Ignore.new(self)
    end

    def bind(&block)
      DParse::Parsers::Bind.new(self, &block)
    end

    def capture
      DParse::Parsers::Capturing.new(self)
    end

    private

    def display(char)
      case char
      when nil
        'end of input'
      when "\n"
        'line break (LF)'
      when "\r"
        'line break (CR)'
      else
        quote_char =
          if char == '\''
            '"'
          else
            '\''
          end

        display_char =
          case char
          when '\\'
            '\\'
          when '"'
            '"'
          when '\''
            '\''
          else
            char.inspect.gsub(/^"|"$/, '')
          end

        quote_char + display_char + quote_char
      end
    end
  end
end
