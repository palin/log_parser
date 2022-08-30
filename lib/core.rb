# frozen_string_literal: true

module LogParser
  require './lib/core/log_line'
  require './lib/core/single_page_info'

  # Parses a log file and returns a hash
  module Core
    def self.run(filename)
      results = prepare_general_results(filename)
      build_output_for_printing(results)
    end

    def self.prepare_general_results(filename)
      File.readlines(filename, chomp: true).each_with_object({}) do |line, results|
        parse_line(results, LogLine.new(line))
      end
    end

    def self.parse_line(results, log_line)
      results[log_line.page] ||= SinglePageInfo.new
      results[log_line.page].add_regular_visit
      results[log_line.page].add_unique_visit(log_line.ip)
    end

    def self.build_output_for_printing(results)
      {
        regular: build_results_for_type(results, :regular),
        unique: build_results_for_type(results, :unique)
      }
    end

    def self.sort_results_for_type(results, type)
      results.sort_by { |_k, v| v.summary[type] }.reverse!
    end

    def self.build_results_for_type(results, type)
      sort_results_for_type(results, type).map { |r| [r.first, r.last.summary[type]] }
    end
  end
end
