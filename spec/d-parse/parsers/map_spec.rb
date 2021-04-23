# frozen_string_literal: true

describe DParse::Parsers::Map do
  let(:inner_parser) { double(:parser) }
  let(:parser) { described_class.new(inner_parser) { |data, slice| [:mapped, data, slice] } }

  describe '#apply / #read' do
    subject { parser.read('abcdefghijklmnopqrstuvwxyz', pos) }

    let(:pos) do
      DParse::Position.new(
        index: 3,
        line: 0,
        column: 3,
      )
    end

    context 'success' do
      before do
        expect(inner_parser).to receive(:read).and_return(
          DParse::Success.new(
            '…',
            DParse::Position.new(index: 10, line: 2, column: 3),
            best_failure: DParse::Failure.new(
              '…',
              DParse::Position.new(index: 20, line: 4, column: 6),
            ),
          ),
        )
      end

      it 'retains successness' do
        expect(subject).to be_a(DParse::Success)
      end

      it 'retains position' do
        expect(subject.pos.index).to eql(10)
        expect(subject.pos.line).to eql(2)
        expect(subject.pos.column).to eql(3)
      end

      it 'maps data' do
        expect(subject.data[0]).to eql(:mapped)
        expect(subject.data[1]).to be(nil)
        expect(subject.data[2].string).to eq('abcdefghijklmnopqrstuvwxyz')
        expect(subject.data[2].from.index).to eq(3)
        expect(subject.data[2].to.index).to eq(10)
        expect(subject.data[2].resolve).to eq('defghij')
      end

      it 'retains best_failure' do
        expect(subject.best_failure).to be_a(DParse::Failure)
        expect(subject.best_failure.pos.index).to eql(20)
        expect(subject.best_failure.pos.line).to eql(4)
        expect(subject.best_failure.pos.column).to eql(6)
      end
    end
  end

  describe '#inspect' do
    subject { parser.inspect }

    before do
      expect(inner_parser).to receive(:inspect).and_return('test_parser()')
    end

    it { is_expected.to eql('map(test_parser(), <proc>)') }
  end
end
