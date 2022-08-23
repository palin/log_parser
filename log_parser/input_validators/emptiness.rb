# frozen_string_literal: true

module LogParser
  module InputValidators
    # Checks if a log file has any content
    module Emptiness
      def self.check(filename, printer: ::LogParser::Printer)
        return unless FileTest.zero?(filename)

        printer.error_message('The file is empty!')
        raise
      end
    end
  end
end
