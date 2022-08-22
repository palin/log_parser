module LogParser
  module Detail
    def line(content)
      puts(content)
    end

    def separator
      line("---")
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

  module Printer
    extend Detail

    def self.summary(filename, results)
      file_info(filename)
      section_header("Most page views (desc):")
      results[:regular].each do |page_summary|
        result(page_summary.first, "#{page_summary.last} views")
      end

      section_header("Most unique page views (desc):")
      results[:unique].each do |page_summary|
        result(page_summary.first, "#{page_summary.last} unique views")
      end
    end

    def self.error_message(msg)
      error(msg)
    end
  end
end
