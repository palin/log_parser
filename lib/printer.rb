# frozen_string_literal: true

module LogParser
  require './lib/printer/drawings'

  # Responsible for printing in stdout
  module Printer
    extend Drawings

    SECTIONS = {
      regular: {
        title: 'Most page views (desc):',
        type: 'views'
      },
      unique: {
        title: 'Most unique page views (desc):',
        type: 'unique views'
      }
    }

    def self.run(filename, results)
      file_info(filename)
      SECTIONS.each do |section_type, copies|
        section_header(copies[:title])
        results[section_type].each do |page_summary|
          result(page_summary.first, "#{page_summary.last} #{copies[:type]}")
        end
      end
    end

    def self.error_message(msg)
      error(msg)
    end
  end
end
