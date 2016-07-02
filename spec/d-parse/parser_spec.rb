describe DParse::Parser do
  context 'bare parser' do
    let(:klass) do
      Class.new(described_class) do
      end
    end

    let(:parser) { klass.new }

    it 'errors on #read' do
      expect { parser.read('foo', :some_pos) }.to raise_error(NotImplementedError)
    end

    it 'errors on #inspect' do
      expect { parser.inspect }.to raise_error(NotImplementedError)
    end
  end

  context 'parser returning an array' do
    let(:klass) do
      Class.new(described_class) do
        def initialize(result)
          @result = result
        end

        def read(input, pos)
          @result
        end

        def inspect
          'sample()'
        end
      end
    end

    let(:result) { DParse::Success.new('…', pos, data: [:a, :b, :c, :d, :e]) }
    let(:pos) { DParse::Position.new(index: 0, line: 0, column: 0) }

    let(:parser) { klass.new(result) }

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

    describe '#match?' do
      subject { parser.match?('…') }

      let(:pos) { DParse::Position.new(index: 0, line: 0, column: 0) }

      context 'failure' do
        let(:result) { DParse::Failure.new('…', pos) }
        it { is_expected.to equal(false) }
      end

      context 'success' do
        let(:result) { DParse::Success.new('…', pos) }
        it { is_expected.to equal(true) }
      end
    end
  end
end
