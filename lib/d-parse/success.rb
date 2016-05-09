module DParse
  class Success
    attr_reader :input
    attr_reader :pos
    attr_reader :data

    def initialize(input, pos, data: nil)
      @input = input
      @pos = pos
      @data = data
    end

    def map
      self.class.new(@input, @pos, data: yield(@data))
    end

    def to_s
      "Success(#{@pos}; #{@data})"
    end

    def success?
      true
    end

    def inspect
      to_s
    end
  end
end
