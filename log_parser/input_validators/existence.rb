# frozen_string_literal: true

module LogParser
  module InputValidators
    module Existence
      def self.check(filename, printer: ::LogParser::Printer)
        unless File.file?(filename)
          printer.error_message("The file doesn't exist!")
          raise
        end
      end
    end
  end
end
