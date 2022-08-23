#!/usr/bin/env ruby
# frozen_string_literal: true

# Main module of the script
module LogParser
  require './log_parser/validator'
  require './log_parser/core'
  require './log_parser/printer'

  def self.run
    filename = ARGV[0]
    Validator.run(filename)
    results = Core.run(filename)
    Printer.run(filename, results)
  end
end

LogParser.run
