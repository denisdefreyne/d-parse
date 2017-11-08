# frozen_string_literal: true

describe DParse::DSL do
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
end
