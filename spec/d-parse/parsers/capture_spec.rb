describe DParse::Parsers::Capturing do
  let(:any) { DParse::Parsers::Any.new }
  let(:parser) { described_class.new(any) }

  example { expect(parser).to parse('a').up_to(1).and_capture('a') }
  example { expect(parser).to parse('aa').up_to(1).and_capture('a')  }
  example { expect(parser).to parse('ab').up_to(1).and_capture('a')  }
  example { expect(parser).to parse('ba').up_to(1).and_capture('b')  }
  example { expect(parser).not_to parse('') }
end
