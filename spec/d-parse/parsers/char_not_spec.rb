describe DParse::Parsers::CharNot do
  let(:parser) { described_class.new('a') }

  example { expect(parser).to parse('b').up_to(1) }
  example { expect(parser).to parse('ba').up_to(1) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected any character not equal to \'a\'') }
  example { expect(parser).not_to parse('a').and_fail_at(0).line(0).column(0).with_failure('expected any character not equal to \'a\'') }
  example { expect(parser).not_to parse('ab').and_fail_at(0).line(0).column(0).with_failure('expected any character not equal to \'a\'') }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('char_not("a")') }
  end
end
