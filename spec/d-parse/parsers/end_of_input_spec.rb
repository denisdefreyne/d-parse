describe DParse::Parsers::EndOfInput do
  let(:parser) { described_class.new }

  example { expect(parser).to parse('') }

  example { expect(parser).not_to parse('a').with_failure('expected end of input, but found \'a\' at line 1, column 1') }
  example { expect(parser).not_to parse("\n").with_failure('expected end of input, but found \'\n\' at line 1, column 1') }
  example { expect(parser).not_to parse('aa').with_failure('expected end of input, but found \'a\' at line 1, column 1') }
end
