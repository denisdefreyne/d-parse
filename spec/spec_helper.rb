# frozen_string_literal: true

require 'rspec'
require 'coveralls'

Coveralls.wear!

require 'd-parse'

RSpec::Matchers.define :parse do |text|
  match do |actual|
    res = actual.apply(text)

    conditions = [
      res.is_a?(DParse::Success),
      -> { (@new_pos.nil? || res.pos.index == @new_pos) },
      -> { (@line.nil? || res.pos.line == @line) },
      -> { (@column.nil? || res.pos.column == @column) },
      -> { (@capture.nil? || @capture == res.data) },
    ]

    conditions.all? { |e| e.respond_to?(:call) ? e.call : e }
  end

  match_when_negated do |actual|
    res = actual.read(text, DParse::Position.new)

    conditions = [
      res.is_a?(DParse::Failure),
      -> { (@new_pos.nil? || res.pos.index == @new_pos) },
      -> { (@line.nil? || res.pos.line == @line) },
      -> { (@column.nil? || res.pos.column == @column) },
      -> { (@failure_msg.nil? || res.message == @failure_msg) },
    ]

    conditions.all? { |e| e.respond_to?(:call) ? e.call : e }
  end

  failure_message do |actual| # expected success, is other success or failure
    res = actual.read(text, DParse::Position.new)

    s = []
    s << "parse #{expected.inspect}"
    case res
    when DParse::Failure
      s << "and not fail (rather than fail with #{res.message.inspect})"
    when DParse::Success
      s << "up to position #{@new_pos} (rather than #{res.pos.index})" if @new_pos && @new_pos != res.pos.index
      s << "line #{@line} (rather than #{res.pos.line})" if @line && @line != res.pos.line
      s << "column #{@column} (rather than #{res.pos.column})" if @column && @column != res.pos.column
      s << "and capture #{@capture.inspect} (rather than #{res.data.inspect})" if @capture && @capture != res.data
    end

    "expected #{actual} to #{s.join(' ')}"
  end

  failure_message_when_negated do |actual| # expected failure, is other failure or success
    res = actual.read(text, DParse::Position.new)

    s = []
    s << "not to parse #{expected.inspect}"
    case res
    when DParse::Success
      s << "and fail (rather than parse up to #{res.pos.inspect})"
    when DParse::Failure
      buts = []
      buts << "with #{@failure_msg.inspect} (rather than #{res.message.inspect})" if @failure_msg && @failure_msg != res.message
      buts << "at position #{@new_pos} (rather than #{res.pos.index})" if @new_pos && @new_pos != res.pos.index
      buts << "line #{@line} (rather than #{res.pos.line})" if @line && @line != res.pos.line
      buts << "column #{@column} (rather than #{res.pos.column})" if @column && @column != res.pos.column

      s <<
        if buts.any?
          "and fail, but #{buts.join(', ')}"
        else
          'and fail'
        end
    end

    "expected #{actual} to #{s.join(' ')}"
  end

  chain :up_to, :new_pos
  chain :and_fail_at, :new_pos
  chain :column, :column
  chain :line, :line

  chain :and_capture, :capture

  chain :with_failure, :failure_msg

  description do
    s = []
    s << "parse #{expected.inspect}"
    s << "up to position #{@new_pos}" if @new_pos
    s << "and capture #{@capture.inspect}" if @capture
    s.join(' ')
  end
end
