describe DParse::Parser do
  context 'parser returning an array' do
    let(:klass) do
      Class.new(described_class) do
        def read(input, pos)
          DParse::Success.new(input, pos, data: [:a, :b, :c, :d, :e])
        end

        def inspect
          'sample()'
        end
      end
    end

    let(:parser) { klass.new }

    describe '#first' do
      subject { parser.first }
      example { expect(subject).to parse('…').and_capture(:a) }
    end

    describe '#second' do
      subject { parser.second }
      example { expect(subject).to parse('…').and_capture(:b) }
    end

    describe '#select_even' do
      subject { parser.select_even }
      example { expect(subject).to parse('…').and_capture([:a, :c, :e]) }
    end

    describe '#select_odd' do
      subject { parser.select_odd }
      example { expect(subject).to parse('…').and_capture([:b, :d]) }
    end
  end
end
