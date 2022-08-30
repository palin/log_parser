# frozen_string_literal: true

module LogParser
  require './lib/validator/existence'
  require './lib/validator/emptiness'

  # Checks if the log file can be parsed
  module Validator
    VALIDATORS = [
      LogParser::Validator::Existence,
      LogParser::Validator::Emptiness
    ].freeze

    def self.run(filename)
      VALIDATORS.each { |validator| validator.check(filename) }
    end
  end
end
