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

  # module ResultSection
  #   extend Detail

  #   def result_section(header, page_text)
  #     section_header(header)
  #     pages.each do |page_summary|
  #       result(page_summary[:page], "#{page_summary[:views_count]} views")
  #     end
  #   end
  # end

  module Printer
    extend Detail

    def self.summary(filename, pages)
      file_info(filename)
      section_header("Most page views (desc):")
      pages.each do |page_summary|
        result(page_summary[:page], "#{page_summary[:views_count]} views")
      end

      section_header("Most unique page views (desc):")
      pages.each do |page_summary|
        result(page_summary[:page], "#{page_summary[:unique_views_count]} unique views")
      end
    end

    def self.error_message(msg)
      error(msg)
    end
  end
end
