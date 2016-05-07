describe DParse::Parsers::Char do
  let(:parser) { described_class.new('a') }

  example { expect(parser).to parse('a') }
  example { expect(parser).to parse('aa') }
  example { expect(parser).to parse('ab') }
  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('b') }
end
