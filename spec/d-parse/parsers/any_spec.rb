describe DParse::Parsers::Any do
  let(:parser) { described_class.new }

  example { expect(parser).to parse('a').up_to(1).line(0).column(1) }
  example { expect(parser).to parse('b').up_to(1).line(0).column(1) }
  example { expect(parser).to parse('ab').up_to(1).line(0).column(1) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected any character (not end of file)') }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('any()') }
  end
end
