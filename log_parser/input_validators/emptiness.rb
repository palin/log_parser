require './log_parser/printer'

module LogParser
  module InputValidators
    module Emptiness
      def self.check(filename, printer: ::LogParser::Printer)
        if FileTest.zero?(filename)
          printer.error_message('The file is empty!')
          raise
        else
          File.open(filename, 'r+')
        end
      end
    end
  end
end
