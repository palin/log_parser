require_relative "../../log_parser/printer"

RSpec.describe LogParser::Printer do
  describe ".summary" do
    let(:filename) { "example.log" }
    let(:results) do
      {
        regular: [
          ["/help_page/1", 8],
          ["/contact", 7],
          ["/about", 6],
          ["/about/2", 6],
          ["/home", 6],
          ["/index", 4],
        ],
        unique: [
          ["/about", 6],
          ["/contact", 6],
          ["/help_page/1", 6],
          ["/about/2", 5],
          ["/home", 5],
          ["/index", 4],
        ]
      }
    end

    subject { described_class.summary(filename, results) }

    it "prints summary in a human-readable way" do
      expect { subject }.to output(
"""Finished parsing file: #{filename}
---
Most page views (desc):
---
/help_page/1 - 8 views
/contact - 7 views
/about - 6 views
/about/2 - 6 views
/home - 6 views
/index - 4 views
---
Most unique page views (desc):
---
/about - 6 unique views
/contact - 6 unique views
/help_page/1 - 6 unique views
/about/2 - 5 unique views
/home - 5 unique views
/index - 4 unique views
"""
      ).to_stdout
    end
  end

  describe ".error_message" do
    let(:msg) { "Are you kidding me? The file doesn't exist..." }

    subject { described_class.error_message(msg) }

    it "prints error message" do
      expect { subject }.to output("ERROR!!! #{msg}\n").to_stdout
    end
  end
end
