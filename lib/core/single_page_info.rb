# frozen_string_literal: true

module LogParser
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
end
