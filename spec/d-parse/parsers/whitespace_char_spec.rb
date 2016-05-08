describe DParse::Parsers::WhitespaceChar do
  let(:parser) { described_class.new }

  example { expect(parser).to parse(' ').up_to(1) }
  example { expect(parser).to parse("\t").up_to(1) }
  example { expect(parser).to parse("\t ").up_to(1) }
  example { expect(parser).to parse(" \t").up_to(1) }
end
