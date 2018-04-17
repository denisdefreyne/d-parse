# frozen_string_literal: true

describe DParse::DSL do
  shared_examples 'repeat zero or more times' do
    it { is_expected.to parse('').up_to(0) }
    it { is_expected.to parse('x').up_to(1) }
    it { is_expected.to parse('xx').up_to(2) }
    it { is_expected.to parse('xxt').up_to(2) }
    it { is_expected.to parse('txx').up_to(0) }
  end

  describe '.any' do
    include described_class

    subject { any }

    it { is_expected.to parse('a') }
    it { is_expected.to parse('é') }
    it { is_expected.not_to parse('') }
  end

  describe '.char' do
    include described_class

    subject { char('x') }

    it { is_expected.to parse('x') }
    it { is_expected.not_to parse('é') }
    it { is_expected.not_to parse('') }
  end

  describe '.repeat' do
    include described_class

    subject { repeat(char('x')) }

    include_examples 'repeat zero or more times'
  end

  describe '.repeat0' do
    include described_class

    subject { repeat0(char('x')) }

    include_examples 'repeat zero or more times'
  end

  describe '.repeat1' do
    include described_class

    subject { repeat1(char('x')) }

    it { is_expected.not_to parse('') }
    it { is_expected.to parse('x').up_to(1) }
    it { is_expected.to parse('xx').up_to(2) }
    it { is_expected.to parse('xxt').up_to(2) }
    it { is_expected.not_to parse('txx') }
  end
end
