module DParse
  class Nothing
    def to_s
      '-'
    end

    def inspect
      '-'
    end

    def +(other)
      other
    end
  end

  NOTHING = Nothing.new
end
