describe DParse::Parsers::Opt do
  let(:char) { DParse::Parsers::Char.new('a') }
  let(:parser) { described_class.new(char) }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('b').up_to(0) }
  example { expect(parser).to parse('ab').up_to(1) }
  example { expect(parser).to parse('ba').up_to(0) }
  example { expect(parser).to parse('').up_to(0) }
end
