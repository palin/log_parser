require_relative "../../../log_parser/input_validators/emptiness"

RSpec.describe LogParser::InputValidators::Emptiness do
  describe ".check" do
    subject { described_class.check(file) }

    context "file is empty" do
      let(:file) { "log_#{Time.now.to_i}.log"}

      before do
        File.open(file, "w+") { |f| f.write("") }
      end

      after do
        File.delete(file) if File.exist?(file)
      end

      it "throws an exception" do
        expect { subject }.to raise_error(StandardError)
      end
    end

    context "file has content" do
      let(:file) { "./logs/webserver.log" }

      it "returns an instance of a File" do
        expect(subject).to be_kind_of(File)
      end
    end
  end
end
