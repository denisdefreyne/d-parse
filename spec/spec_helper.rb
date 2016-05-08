require 'rspec'

require 'd-parse'

RSpec::Matchers.define :be_success do
  match do |actual|
    actual.is_a?(DParse::Success)
  end

  match_when_negated do |actual|
    actual.is_a?(DParse::Failure)
  end
end

RSpec::Matchers.define :parse do |text|
  match do |actual|
    res = actual.read(text, DParse::Position.new)
    res.is_a?(DParse::Success) && (@new_pos.nil? || res.pos.index == @new_pos) && (@capture.nil? || @capture == res.data)
  end

  match_when_negated do |actual|
    res = actual.read(text, DParse::Position.new)
    res.is_a?(DParse::Failure) && (@new_pos.nil? || res.pos.index == @new_pos) && (@capture.nil? || @capture == res.data)
  end

  failure_message do |actual|
    res = actual.read(text, DParse::Position.new)

    s = []
    s << "parse #{expected.inspect}"
    s << "up to position #{@new_pos} (rather than #{res.pos.index})" if @new_pos && @new_pos != res.pos.index
    s << "and capture #{@capture.inspect} (rather than #{res.data.inspect})" if @capture && @capture != res.data

    "expected that #{actual} would #{s.join(' ')}"
  end

  chain :up_to, :new_pos
  chain :and_capture, :capture

  description do
    s = []
    s << "parse #{expected.inspect}"
    s << "up to position #{@new_pos}" if @new_pos
    s << "and capture #{@capture.inspect}" if @capture
    s.join(' ')
  end
end
