# frozen_string_literal: true

describe DParse::Parsers::Capturing do
  let(:any) { DParse::Parsers::Any.new }
  let(:parser) { described_class.new(any) }

  example { expect(parser).to parse('a').up_to(1).line(0).column(1).and_capture('a') }
  example { expect(parser).to parse('aa').up_to(1).line(0).column(1).and_capture('a')  }
  example { expect(parser).to parse('ab').up_to(1).line(0).column(1).and_capture('a')  }
  example { expect(parser).to parse('ba').up_to(1).line(0).column(1).and_capture('b')  }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0) }
end
