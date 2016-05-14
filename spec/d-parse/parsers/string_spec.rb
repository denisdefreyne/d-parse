describe DParse::Parsers::String do
  let(:parser) { described_class.new('donkey') }

  example { expect(parser).to parse('donkey').up_to(6) }
  example { expect(parser).to parse('donkeys').up_to(6) }
  example { expect(parser).to parse('donkey mania').up_to(6) }

  example { expect(parser).not_to parse('') }
  example { expect(parser).not_to parse('d') }
  example { expect(parser).not_to parse('donke') }
  example { expect(parser).not_to parse('some donkey') }
  example { expect(parser).not_to parse('giraffe') }

  describe '#inspect' do
    subject { parser.inspect }

    it { is_expected.to eql('seq(char("d"),char("o"),char("n"),char("k"),char("e"),char("y"))') }
  end
end
