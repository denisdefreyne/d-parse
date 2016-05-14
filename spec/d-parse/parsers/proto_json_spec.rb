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

  example { expect(parser).to parse('{"a":"b"}').and_capture('a' => 'b') }
  example { expect(parser).to parse('{ "a" : "b" }').and_capture('a' => 'b') }
  example { expect(parser).to parse("{\t\"a\"\t:\t\"b\"\t}").and_capture('a' => 'b') }
  example { expect(parser).to parse("{\r\"a\"\r:\r\"b\"\r}").and_capture('a' => 'b') }
  example { expect(parser).to parse("{\n\"a\"\n:\n\"b\"\n}").and_capture('a' => 'b') }

  example { expect(parser).to parse('{"num":0}').up_to(9).and_capture('num' => 0) }
  example { expect(parser).to parse('{"nu m":0}').up_to(10).and_capture('nu m' => 0) }
  example { expect(parser).to parse('{"nu\"m":0}').up_to(11).and_capture('nu"m' => 0) }
  example { expect(parser).to parse('{"nu\\\\m":0}').up_to(11).and_capture('nu\\m' => 0) }
  example { expect(parser).to parse('{"nu\\/m":0}').up_to(11).and_capture('nu/m' => 0) }
  example { expect(parser).to parse('{"nu\\bm":0}').up_to(11).and_capture("nu\bm" => 0) }
  example { expect(parser).to parse('{"nu\\fm":0}').up_to(11).and_capture("nu\fm" => 0) }
  example { expect(parser).to parse('{"nu\\nm":0}').up_to(11).and_capture("nu\nm" => 0) }
  example { expect(parser).to parse('{"nu\\rm":0}').up_to(11).and_capture("nu\rm" => 0) }
  example { expect(parser).to parse('{"nu\\tm":0}').up_to(11).and_capture("nu\tm" => 0) }
  example { expect(parser).to parse('{"nu\\u0000m":0}').up_to(15).and_capture("nu\u0000m" => 0) }
  example { expect(parser).to parse('{"nu\\u0020m":0}').up_to(15).and_capture('nu m' => 0) }

  example { expect(parser).to parse('{"num":0}').up_to(9).and_capture('num' => 0) }
  example { expect(parser).to parse('{"num":-0}').up_to(10).and_capture('num' => 0) }
  example { expect(parser).to parse('{"num":3}').up_to(9).and_capture('num' => 3) }
  example { expect(parser).to parse('{"num":-3}').up_to(10).and_capture('num' => -3) }
  example { expect(parser).to parse('{"num":0.1}').up_to(11).and_capture('num' => 0.1) }
  example { expect(parser).to parse('{"num":-0.1}').up_to(12).and_capture('num' => -0.1) }

  example { expect(parser).to parse('{"num":0e1}').up_to(11).and_capture('num' => 0) }
  example { expect(parser).to parse('{"num":0E1}').up_to(11).and_capture('num' => 0) }
  example { expect(parser).to parse('{"num":0e2}').up_to(11).and_capture('num' => 0) }
  example { expect(parser).to parse('{"num":0E2}').up_to(11).and_capture('num' => 0) }

  example { expect(parser).to parse('{"num":2e1}').up_to(11).and_capture('num' => 20) }
  example { expect(parser).to parse('{"num":2E1}').up_to(11).and_capture('num' => 20) }
  example { expect(parser).to parse('{"num":2e2}').up_to(11).and_capture('num' => 200) }
  example { expect(parser).to parse('{"num":2E2}').up_to(11).and_capture('num' => 200) }

  example { expect(parser).to parse('{"num":2.1e1}').up_to(13).and_capture('num' => 21.0) }
  example { expect(parser).to parse('{"num":2.1E1}').up_to(13).and_capture('num' => 21.0) }
  example { expect(parser).to parse('{"num":2.1e2}').up_to(13).and_capture('num' => 210.0) }
  example { expect(parser).to parse('{"num":2.1E2}').up_to(13).and_capture('num' => 210.0) }
end
