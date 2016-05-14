describe DParse::Parsers::CharIn do
  let(:parser) { described_class.new(%w( a b )) }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('b').up_to(1) }
  example { expect(parser).to parse('ab').up_to(1) }
  example { expect(parser).to parse('ac').up_to(1) }
  example { expect(parser).to parse('ba').up_to(1) }
  example { expect(parser).to parse('bc').up_to(1) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0) }
  example { expect(parser).not_to parse('c').and_fail_at(0).line(0).column(0) }
  example { expect(parser).not_to parse('d').and_fail_at(0).line(0).column(0) }
  example { expect(parser).not_to parse('ca').and_fail_at(0).line(0).column(0) }
  example { expect(parser).not_to parse('db').and_fail_at(0).line(0).column(0) }
end
