describe DParse::Parsers::Alt do
  let(:a) { DParse::Parsers::Char.new('a') }
  let(:b) { DParse::Parsers::Char.new('b') }
  let(:parser) { described_class.new(a, b) }

  example { expect(parser).to parse('a') }
  example { expect(parser).to parse('aa') }
  example { expect(parser).to parse('ab') }
  example { expect(parser).to parse('ac') }
  example { expect(parser).to parse('b') }
  example { expect(parser).to parse('ba') }
  example { expect(parser).to parse('bb') }
  example { expect(parser).to parse('bc') }

  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('c') }
  example { expect(parser).not_to parse('ca') }
  example { expect(parser).not_to parse('cb') }
  example { expect(parser).not_to parse('cc') }
end
