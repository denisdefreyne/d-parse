# frozen_string_literal: true

describe DParse::Parsers::Intersperse do
  let(:a) { DParse::Parsers::Char.new('a') }
  let(:b) { DParse::Parsers::Char.new(',') }
  let(:parser) { described_class.new(a, b) }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('a,a').up_to(3) }
  example { expect(parser).to parse('a,a,a').up_to(5) }

  example { expect(parser).to parse('a,').up_to(1) }
  example { expect(parser).to parse('a,a,').up_to(3) }

  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse(',') }
  example { expect(parser).not_to parse(',a') }
  example { expect(parser).not_to parse(',a,') }
  example { expect(parser).not_to parse(',a,a') }
end
