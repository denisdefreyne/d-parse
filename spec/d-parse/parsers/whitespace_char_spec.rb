# frozen_string_literal: true

describe DParse::Parsers::WhitespaceChar do
  let(:parser) { described_class.new }

  example { expect(parser).to parse(' ').up_to(1) }
  example { expect(parser).to parse("\t").up_to(1) }
  example { expect(parser).to parse("\t ").up_to(1) }
  example { expect(parser).to parse(" \t").up_to(1) }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('alt(char(" "),char("\\t"))') }
  end
end
