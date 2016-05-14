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
end
