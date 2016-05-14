describe DParse::Parsers::Char do
  let(:parser) { described_class.new('a') }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('aa').up_to(1) }
  example { expect(parser).to parse('ab').up_to(1) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected \'a\', but found end of input') }
  example { expect(parser).not_to parse('b').and_fail_at(0).line(0).column(0).with_failure('expected \'a\', but found \'b\'') }

  context 'newline parser' do
    let(:parser) { described_class.new("\n") }

    example { expect(parser).to parse("\n").up_to(1).line(1).column(0) }
  end
end
