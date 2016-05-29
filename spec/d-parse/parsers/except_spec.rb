describe DParse::Parsers::Except do
  let(:parser) { described_class.new(initial_parser, bad_parser) }

  let(:initial_parser) { DParse::Parsers::Any.new }
  let(:bad_parser) { DParse::Parsers::Char.new('x') }

  example { expect(parser).to parse('a').up_to(1) }
  example { expect(parser).to parse('aa').up_to(1) }
  example { expect(parser).to parse('ax').up_to(1) }
  example { expect(parser).not_to parse('x').and_fail_at(0).line(0).column(0).with_failure('expected any character except end of file, not \'x\'') }
  example { expect(parser).not_to parse('xa').and_fail_at(0).line(0).column(0).with_failure('expected any character except end of file, not \'x\'') }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected any character except end of file') }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('except(any(), char("x"))') }
  end
end
