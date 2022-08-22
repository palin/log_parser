# frozen_string_literal: true

require_relative 'input_validators/existence'
require_relative 'input_validators/emptiness'

module LogParser
  module InputValidator
    VALIDATORS = [
      LogParser::InputValidators::Existence,
      LogParser::InputValidators::Emptiness
    ].freeze

    def self.run(filename)
      VALIDATORS.each { |validator| validator.check(filename) }
    end
  end
end
