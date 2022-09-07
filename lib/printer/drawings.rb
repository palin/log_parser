# frozen_string_literal: true

module LogParser
  # Helper module for Printer
  module Drawings
    def line(content)
      puts(content)
    end

    def separator
      line('---')
    end

    def result(page, text)
      line("#{page} - #{text}")
    end

    def file_info(filename)
      line("Finished parsing file: #{filename}")
    end

    def error(text)
      line("ERROR!!! #{text}")
    end

    def section_header(text)
      separator
      line(text)
      separator
    end
  end
end
