# frozen_string_literal: true

module LogParser
  module InputValidators
    module Emptiness
      def self.check(filename, printer: ::LogParser::Printer)
        if FileTest.zero?(filename)
          printer.error_message('The file is empty!')
          raise
        end
      end
    end
  end
end
