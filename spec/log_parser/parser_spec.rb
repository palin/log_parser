require_relative "../../log_parser/parser"

RSpec.describe LogParser::Parser do
  describe ".run" do
    let(:filename) { "example.log" }

    subject { described_class.run(filename) }

    it "runs" do
      expect(subject).to eq(filename)
    end
  end
end
