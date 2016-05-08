describe DParse::Parsers::Char do
  let(:parser) { described_class.new('a') }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('aa').up_to(1) }
  example { expect(parser).to parse('ab').up_to(1) }
  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('b') }
end
