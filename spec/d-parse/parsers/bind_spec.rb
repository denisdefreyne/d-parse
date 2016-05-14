describe DParse::Parsers::Bind do
  let(:a) { DParse::Parsers::Char.new('a') }
  let(:b) { DParse::Parsers::Char.new('b') }

  let(:init) { DParse::Parsers::Alt.new(a, b).capture }

  let(:parser) do
    parser_map = {
      'a' => DParse::Parsers::Char.new('0'),
      'b' => DParse::Parsers::Char.new('1'),
    }

    init.bind do |data|
      new_parser = parser_map[data]
      new_parser.map { |d| [data, d] }
    end
  end

  example { expect(parser).to parse('a0').up_to(2).line(0).column(2) }
  example { expect(parser).to parse('b1').up_to(2).line(0).column(2) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0) }
  example { expect(parser).not_to parse('a').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('aa').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('ab').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('a1').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('b').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('ba').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('bb').and_fail_at(1).line(0).column(1) }
  example { expect(parser).not_to parse('b0').and_fail_at(1).line(0).column(1) }
end
