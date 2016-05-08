describe DParse::Parsers::Sequence do
  let(:char_a) { DParse::Parsers::Char.new('a') }
  let(:char_b) { DParse::Parsers::Char.new('b') }
  let(:parser) { char_a >> char_b }

  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('a') }
  example { expect(parser).not_to parse('b') }
  example { expect(parser).not_to parse('ba') }

  example { expect(parser).to parse('ab').up_to(2) }
  example { expect(parser).to parse('aba').up_to(2) }
  example { expect(parser).to parse('abb').up_to(2) }
end
