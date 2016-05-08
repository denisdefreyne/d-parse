describe DParse::Parsers::NotChars do
  let(:parser) { described_class.new('a', 'b') }

  example { expect(parser).to parse('c').up_to(1) }
  example { expect(parser).to parse('ca').up_to(1) }
  example { expect(parser).to parse('cb').up_to(1) }
  example { expect(parser).to parse('cab').up_to(1) }

  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('a') }
  example { expect(parser).not_to parse('ab') }
  example { expect(parser).not_to parse('ac') }
  example { expect(parser).not_to parse('b') }
  example { expect(parser).not_to parse('ba') }
  example { expect(parser).not_to parse('bb') }
  example { expect(parser).not_to parse('bc') }
end
