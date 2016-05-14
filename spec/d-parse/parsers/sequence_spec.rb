describe DParse::Parsers::Seq do
  let(:char_a) { DParse::Parsers::Char.new('a') }
  let(:char_b) { DParse::Parsers::Char.new('b') }
  let(:parser) { described_class.new(char_a, char_b) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected \'a\', but found end of input') }
  example { expect(parser).not_to parse('a').and_fail_at(1).line(0).column(1).with_failure('expected \'b\', but found end of input') }
  example { expect(parser).not_to parse('ac').and_fail_at(1).line(0).column(1).with_failure('expected \'b\', but found \'c\'') }
  example { expect(parser).not_to parse('b').and_fail_at(0).line(0).column(0).with_failure('expected \'a\', but found \'b\'') }
  example { expect(parser).not_to parse('ba').and_fail_at(0).line(0).column(0).with_failure('expected \'a\', but found \'b\'') }

  example { expect(parser).to parse('ab').up_to(2) }
  example { expect(parser).to parse('aba').up_to(2) }
  example { expect(parser).to parse('abb').up_to(2) }
end
