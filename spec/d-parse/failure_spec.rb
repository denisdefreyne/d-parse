describe DParse::Failure do
  let(:failure) { described_class.new("one\ntwo\nthree\nfour\nfive", position, message: message) }

  let(:position) { DParse::Position.new(index: 13, line: 2, column: 3) }
  let(:message) { 'argh' }

  describe '#full_message' do
    subject { failure.full_message }
    it { is_expected.to eql('argh at line 3, column 4') }
  end

  describe '#pretty_message' do
    subject { failure.pretty_message }

    context 'column 3' do
      let(:position) { DParse::Position.new(index: 13, line: 2, column: 3) }
      it { is_expected.to eql("argh at line 3, column 4\n\nthr\e[31me\e[0me\n\e[31m   ↑\e[0m") }
    end

    context 'column 4' do
      let(:position) { DParse::Position.new(index: 14, line: 2, column: 4) }
      it { is_expected.to eql("argh at line 3, column 5\n\nthre\e[31me\e[0m\n\e[31m    ↑\e[0m") }
    end

    context 'column 5' do
      let(:position) { DParse::Position.new(index: 15, line: 2, column: 5) }
      it { is_expected.to eql("argh at line 3, column 6\n\nthree\n\e[31m     ↑\e[0m") }
    end
  end
end
