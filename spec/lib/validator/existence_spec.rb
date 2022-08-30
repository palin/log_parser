# frozen_string_literal: true

describe LogParser::Validator::Existence do
  describe '.check' do
    subject { described_class.check(file) }

    context "file doesn't exist" do
      let(:file) { 'blah.log' }

      it 'throws an exception' do
        expect { subject }.to raise_error(StandardError)
      end

      it 'calls for printer' do
        expect(LogParser::Printer).to receive(:error_message).with("The file doesn't exist!").once
        begin
          subject
        rescue StandardError
          StandardError
        end
      end
    end

    context 'file exists' do
      let(:file) { './logs/webserver.log' }

      it "doesn't throw any exception" do
        expect { subject }.not_to raise_error
      end
    end
  end
end
