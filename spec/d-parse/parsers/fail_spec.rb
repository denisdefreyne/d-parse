describe DParse::Parsers::Fail do
  let(:parser) { described_class.new }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected nothing (always fail)') }
  example { expect(parser).not_to parse('a').and_fail_at(0).line(0).column(0).with_failure('expected nothing (always fail)') }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('fail()') }
  end
end
