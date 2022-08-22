# frozen_string_literal: true

module LogParser
  module Validator
    require './log_parser/input_validators/existence'
    require './log_parser/input_validators/emptiness'

    VALIDATORS = [
      LogParser::InputValidators::Existence,
      LogParser::InputValidators::Emptiness
    ].freeze

    def self.run(filename)
      VALIDATORS.each { |validator| validator.check(filename) }
    end
  end
end
