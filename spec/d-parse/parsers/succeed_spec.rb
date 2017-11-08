# frozen_string_literal: true

describe DParse::Parsers::Succeed do
  let(:parser) { described_class.new }

  example { expect(parser).to parse('').up_to(0).line(0).column(0) }
  example { expect(parser).to parse('a').up_to(0).line(0).column(0) }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('succeed()') }
  end
end
