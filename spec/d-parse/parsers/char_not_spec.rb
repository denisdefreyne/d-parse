describe DParse::Parsers::CharNot do
  let(:parser) { described_class.new('a') }

  example { expect(parser).to parse('b').up_to(1) }
  example { expect(parser).to parse('ba').up_to(1) }

  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('a') }
  example { expect(parser).not_to parse('ab') }
end
