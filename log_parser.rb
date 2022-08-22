#!/usr/bin/env ruby

require "./log_parser/input_validator"
require "./log_parser/parser"
require "./log_parser/printer"

module LogParser
  def self.run
    filename = ARGV[0]
    input = InputValidator.run(filename)
    results = Parser.run(input)
    Printer.run(results)
  end
end

LogParser.run
