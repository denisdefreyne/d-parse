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
    res.is_a?(DParse::Success)
  end

  match_when_negated do |actual|
    res = actual.read(text, DParse::Position.new)
    res.is_a?(DParse::Failure)
  end
end
