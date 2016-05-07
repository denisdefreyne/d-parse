module DParse
  class Success
    attr_reader :pos
    attr_reader :data

    def initialize(pos, data: NOTHING)
      @pos = pos
      @data = data
    end

    def map
      self.class.new(@pos, data: yield(@data))
    end

    def to_s
      "Success(#{@pos}; #{@data})"
    end

    def inspect
      to_s
    end
  end
end
