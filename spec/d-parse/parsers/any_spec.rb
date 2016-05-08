describe DParse::Parsers::Any do
  let(:parser) { described_class.new }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('b').up_to(1) }
  example { expect(parser).to parse('ab').up_to(1) }
  example { expect(parser).not_to parse('') }
end
