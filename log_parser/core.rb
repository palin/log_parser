module LogParser
  module Core
    LOG_LINE_REGEX = /(\S*)\s([0-9\.]+)/.freeze

    def self.run(filename)
      results = prepare_general_results(filename)
      build_for_output(results)
    end

    private

    def self.prepare_general_results(filename)
      results = {}

      File.readlines(filename, chomp: true).each do |line|
        result = line.strip.split(" ")
        page = result[0]
        ip = result[1]
        results[page] ||= { regular: 0, unique: 0, unique_ips: [] }

        regular = results.dig(page, :regular) + 1
        if results[page][:unique_ips].include?(ip)
          unique = results[page][:unique]
          unique_ips = results[page][:unique_ips]
        else
          unique = results[page][:unique] + 1
          unique_ips = results[page][:unique_ips] << ip
        end

        results[page] = { regular: regular, unique: unique, unique_ips: unique_ips }
      end

      results
    end

    def self.build_for_output(results)
      {
        regular: build_results_for_type(results, :regular),
        unique: build_results_for_type(results, :unique),
      }
    end

    def self.sort_results_for_type(results, type)
      results.sort_by { |k, v| v[type] }.reverse!
    end

    def self.build_results_for_type(results, type)
      sort_results_for_type(results, type).map { |r| [r.first, r.last[type]] }
    end
  end
end