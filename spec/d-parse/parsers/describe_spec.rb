describe DParse::Parsers::Describe do
  let(:identifier) do
    DParse::Parsers::Seq.new(
      DParse::Parsers::Repeat.new(
        DParse::Parsers::CharIn.new('a'..'z'),
      ),
      DParse::Parsers::EOF.new,
    )
  end

  let(:parser) { described_class.new(identifier, 'identifier') }

  example { expect(parser).not_to parse('0123').and_fail_at(0).line(0).column(0).with_failure('expected identifier') }

  describe '#inspect' do
    subject { parser.inspect }

    let(:identifier) { DParse::Parsers::Char.new('a') }

    it { is_expected.to eql('identifier()') }
  end
end
