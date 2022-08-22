#!/usr/bin/env ruby

require './log_parser/input_validator'
require './log_parser/core'
require './log_parser/printer'

module LogParser
  def self.run
    filename = ARGV[0]
    InputValidator.run(filename)
    results = Core.run(filename)
    Printer.summary(filename, results)
  end
end

LogParser.run
