# frozen_string_literal: true

module LogParser
  # Represents a single line of a log
  LogLine = Struct.new(:line) do
    def page
      line_parts[0]
    end

    def ip
      line_parts[1]
    end

    private

    def line_parts
      line.strip.split(' ')
    end
  end
end
