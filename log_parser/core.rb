# frozen_string_literal: true

module LogParser
  LogLine = Struct.new(:line) do
    def page
      line.strip.split(' ')[0]
    end

    def ip
      line.strip.split(' ')[1]
    end
  end

  # Helper class for storing single page data from logs
  class SinglePageInfo
    attr_reader :summary

    def initialize
      @summary = { regular: 0, unique: 0, unique_ips: [] }
    end

    def add_regular_visit
      @summary[:regular] += 1
    end

    def add_unique_visit(ip)
      return if @summary[:unique_ips].include?(ip)

      @summary[:unique] += 1
      @summary[:unique_ips] << ip
    end
  end

  # Parses a log file and returns a hash
  module Core
    def self.run(filename)
      results = prepare_general_results(filename)
      build_output_for_printing(results)
    end

    def self.prepare_general_results(filename)
      File.readlines(filename, chomp: true).each_with_object({}) do |line, results|
        log_line = LogLine.new(line)

        results[log_line.page] ||= SinglePageInfo.new
        results[log_line.page].add_regular_visit
        results[log_line.page].add_unique_visit(log_line.ip)
      end
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
