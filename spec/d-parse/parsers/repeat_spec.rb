describe DParse::Parsers::Repeat do
  let(:char) { DParse::Parsers::Char.new('a') }
  let(:parser) { described_class.new(char) }

  example { expect(parser).to parse('').up_to(0) }
  example { expect(parser).to parse('b').up_to(0) }
  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('ab').up_to(1) }
  example { expect(parser).to parse('aa').up_to(2) }
  example { expect(parser).to parse('aab').up_to(2) }
  example { expect(parser).to parse('aaa').up_to(3) }
  example { expect(parser).to parse('aaab').up_to(3) }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('repeat(char("a"))') }
  end

  context 'successes with associated failures' do
    let(:parser) { described_class.new(DParse::Parsers::String.new('hello')) }

    it 'picks the most specific failure' do
      expect(parser.apply('hell')).to be_a(DParse::Success)
      expect(parser.apply('hell').pos.index).to eql(0)
      expect(parser.apply('hell').best_failure).to be_a(DParse::Failure)
      expect(parser.apply('hell').best_failure.pos.index).to eql(4)

      expect(parser.apply('hello')).to be_a(DParse::Success)
      expect(parser.apply('hello').pos.index).to eql(5)
      expect(parser.apply('hello').best_failure).to be_a(DParse::Failure)
      expect(parser.apply('hello').best_failure.pos.index).to eql(5)

      expect(parser.apply('helloh')).to be_a(DParse::Success)
      expect(parser.apply('helloh').pos.index).to eql(5)
      expect(parser.apply('helloh').best_failure).to be_a(DParse::Failure)
      expect(parser.apply('helloh').best_failure.pos.index).to eql(6)
    end
  end
end
