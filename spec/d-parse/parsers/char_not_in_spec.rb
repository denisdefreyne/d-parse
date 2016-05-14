describe DParse::Parsers::CharNotIn do
  let(:parser) { described_class.new(%w( a b )) }

  example { expect(parser).to parse('c').up_to(1) }
  example { expect(parser).to parse('ca').up_to(1) }
  example { expect(parser).to parse('cb').up_to(1) }
  example { expect(parser).to parse('cab').up_to(1) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('a').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('ab').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('ac').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('b').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('ba').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('bb').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }
  example { expect(parser).not_to parse('bc').and_fail_at(0).line(0).column(0).with_failure('expected any character not in \'a\', \'b\'') }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('char_not_in(["a", "b"])') }
  end
end
