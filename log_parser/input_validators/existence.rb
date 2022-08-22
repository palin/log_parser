# frozen_string_literal: true

require './log_parser/printer'

module LogParser
  module InputValidators
    module Existence
      def self.check(filename, printer: ::LogParser::Printer)
        File.open(filename, 'r+')
      rescue Errno::ENOENT => e
        printer.error_message("The file doesn't exist!")
        raise e
      end
    end
  end
end
