describe DParse::Parsers::EndOfInput do
  let(:parser) { described_class.new }

  example { expect(parser).to parse('') }
  example { expect(parser).not_to parse('a') }
  example { expect(parser).not_to parse('aa') }
end
