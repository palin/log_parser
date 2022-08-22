require_relative "../../log_parser/printer"

RSpec.describe LogParser::Printer do
  describe ".summary" do
    let(:filename) { "example.log" }
    let(:pages) do
      [
        { page: "/help_page/1", views_count: 8, unique_views_count: 6 },
        { page: "/contact", views_count: 7, unique_views_count: 6 },
        { page: "/about", views_count: 6, unique_views_count: 6 },
        { page: "/about/2", views_count: 6, unique_views_count: 5 },
        { page: "/home", views_count: 6, unique_views_count: 5 },
        { page: "/index", views_count: 4, unique_views_count: 4 },
      ]
    end

    subject { described_class.summary(filename, pages) }

    it "prints pages summary in a human-readable way" do
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
/help_page/1 - 6 unique views
/contact - 6 unique views
/about - 6 unique views
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
