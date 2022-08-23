# frozen_string_literal: true

module LogParser
  module InputValidators
    # Checks if a log file exists
    module Existence
      def self.check(filename, printer: ::LogParser::Printer)
        return if File.file?(filename)

        printer.error_message("The file doesn't exist!")
        raise
      end
    end
  end
end
