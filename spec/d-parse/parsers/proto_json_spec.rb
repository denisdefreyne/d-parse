describe DParse::Parsers::ProtoJSON do
  let(:parser) { described_class.new }

  let(:input) do
    '{"name": "Denis", "favourite_animals": ["donkey", "giraffe"], "nothing": null, "yup": true, "nope": false, "one": 1, "zero": 0, "two": 2, "object": {"foo":"bar"} }'
  end

  let(:expected_capture) do
    {
      'name' => 'Denis',
      'favourite_animals' => %w( donkey giraffe ),
      'nothing' => nil,
      'yup' => true,
      'nope' => false,
      'one' => 1,
      'zero' => 0,
      'two' => 2,
      'object' => { 'foo' => 'bar' },
    }
  end

  example { expect(parser).to parse(input).up_to(163).and_capture(expected_capture) }
end
