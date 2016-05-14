describe DParse::Parsers::Alt do
  let(:a) { DParse::Parsers::String.new('Hello') }
  let(:b) { DParse::Parsers::String.new('Goodbye') }
  let(:parser) { described_class.new(a, b) }

  example { expect(parser).to parse('Hello').up_to(5).line(0).column(5) }
  example { expect(parser).to parse('Goodbye').up_to(7).line(0).column(7) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected \'G\'') }
  example { expect(parser).not_to parse('Wilkommen').and_fail_at(0).line(0).column(0).with_failure('expected \'G\'') }
  example { expect(parser).not_to parse('Hallo').and_fail_at(1).line(0).column(1).with_failure('expected \'e\'') }
  example { expect(parser).not_to parse('Hellenistic period').and_fail_at(4).line(0).column(4).with_failure('expected \'o\'') }
end
