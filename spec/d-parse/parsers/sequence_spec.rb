describe DParse::Parsers::Seq do
  let(:char_a) { DParse::Parsers::Char.new('a') }
  let(:char_b) { DParse::Parsers::Char.new('b') }
  let(:parser) { described_class.new(char_a, char_b) }

  example { expect(parser).not_to parse('').and_fail_at(0).line(0).column(0).with_failure('expected \'a\'') }
  example { expect(parser).not_to parse('a').and_fail_at(1).line(0).column(1).with_failure('expected \'b\'') }
  example { expect(parser).not_to parse('ac').and_fail_at(1).line(0).column(1).with_failure('expected \'b\'') }
  example { expect(parser).not_to parse('b').and_fail_at(0).line(0).column(0).with_failure('expected \'a\'') }
  example { expect(parser).not_to parse('ba').and_fail_at(0).line(0).column(0).with_failure('expected \'a\'') }

  example { expect(parser).to parse('ab').up_to(2) }
  example { expect(parser).to parse('aba').up_to(2) }
  example { expect(parser).to parse('abb').up_to(2) }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('seq(char("a"),char("b"))') }
  end

  context 'successes with associated failures' do
    let(:a) { double('parser') }
    let(:b) { double('parser') }

    before do
      expect(a).to receive(:read).and_return(
        DParse::Success.new(
          '…',
          DParse::Position.new(index: 1, line: 0, column: 1),
          best_failure: DParse::Failure.new(
            '…',
            DParse::Position.new(index: 20, line: 0, column: 20),
          ),
        ),
      )

      expect(b).to receive(:read).and_return(
        DParse::Failure.new(
          '…',
          DParse::Position.new(index: 10, line: 0, column: 10),
        ),
      )
    end

    let(:parser) { described_class.new(a, b) }

    it 'picks the most specific failure' do
      expect(parser).not_to parse('…').and_fail_at(20).line(0).column(20)
    end
  end
end
