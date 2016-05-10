describe DParse::Parsers::Sequence do
  let(:char_a) { DParse::Parsers::Char.new('a') }
  let(:char_b) { DParse::Parsers::Char.new('b') }
  let(:parser) { described_class.new(char_a, char_b) }

  example { expect(parser).not_to parse('').with_failure('expected \'a\', but found end of input at line 1, column 1') }
  example { expect(parser).not_to parse('a').with_failure('expected \'b\', but found end of input at line 1, column 2') }
  example { expect(parser).not_to parse('ac').with_failure('expected \'b\', but found \'c\' at line 1, column 2') }
  example { expect(parser).not_to parse('b').with_failure('expected \'a\', but found \'b\' at line 1, column 1') }
  example { expect(parser).not_to parse('ba').with_failure('expected \'a\', but found \'b\' at line 1, column 1') }

  example { expect(parser).to parse('ab').up_to(2) }
  example { expect(parser).to parse('aba').up_to(2) }
  example { expect(parser).to parse('abb').up_to(2) }
end
