# frozen_string_literal: true

describe DParse::Parsers::Alt do
  let(:a) { DParse::Parsers::String.new('Hello') }
  let(:b) { DParse::Parsers::String.new('Goodbye') }
  let(:parser) { described_class.new(a, b) }

  example { expect(parser).to parse('Hello').up_to(5).line(0).column(5) }
  example { expect(parser).to parse('Goodbye').up_to(7).line(0).column(7) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected string["Hello"]') }
  example { expect(parser).not_to parse('Wilkommen').and_fail_at(0).line(0).column(0).with_failure('expected string["Hello"]') }
  example { expect(parser).not_to parse('Hallo').and_fail_at(1).line(0).column(1).with_failure('expected string["Hello"]') }
  example { expect(parser).not_to parse('Hellenistic period').and_fail_at(4).line(0).column(4).with_failure('expected string["Hello"]') }

  describe '#inspect' do
    subject { parser.inspect }

    let(:a) { DParse::Parsers::Char.new('a') }
    let(:b) { DParse::Parsers::Char.new('b') }

    it { is_expected.to eql('alt(char("a"),char("b"))') }
  end

  context 'ambiguous parsers' do
    let(:a) { double('parser') }
    let(:b) { double('parser') }

    before do
      expect(a).to receive(:read).and_return(DParse::Failure.new('…', DParse::Position.new(index: 10, line: 0, column: 10)))
      expect(b).to receive(:read).and_return(DParse::Failure.new('…', DParse::Position.new(index: 20, line: 0, column: 20)))
    end

    context 'shortest first' do
      let(:parser) { described_class.new(a, b) }

      it 'picks the most specific failure' do
        expect(parser).not_to parse('…').and_fail_at(20).line(0).column(20)
      end
    end

    context 'longest first' do
      let(:parser) { described_class.new(b, a) }

      it 'picks the most specific failure' do
        expect(parser).not_to parse('…').and_fail_at(20).line(0).column(20)
      end
    end
  end
end
