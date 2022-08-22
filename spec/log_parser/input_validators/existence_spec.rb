# frozen_string_literal: true

require_relative '../../../log_parser/input_validators/existence'

RSpec.describe LogParser::InputValidators::Existence do
  describe '.check' do
    subject { described_class.check(file) }

    context "file doesn't exist" do
      let(:file) { 'blah.log' }

      it 'throws an exception' do
        expect { subject }.to raise_error(StandardError)
      end

      it 'calls for printer' do
        expect(LogParser::Printer).to receive(:error_message).with("The file doesn't exist!").once
        subject rescue StandardError
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
