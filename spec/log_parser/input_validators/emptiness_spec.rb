# frozen_string_literal: true

describe LogParser::InputValidators::Emptiness do
  describe '.check' do
    subject { described_class.check(log_file_path) }

    context 'file is empty' do
      let(:log_file_path) { "log_#{Time.now.to_i}.log" }

      before { create_file(log_file_path, '') }

      after { delete_file(log_file_path) }

      it 'throws an exception' do
        expect { subject }.to raise_error(StandardError)
      end

      it 'calls for printer' do
        expect(LogParser::Printer).to receive(:error_message).with('The file is empty!').once
        subject rescue StandardError
      end
    end

    context 'file has content' do
      let(:log_file_path) { './logs/webserver.log' }

      it "doesn't throw any exception" do
        expect { subject }.not_to raise_error
      end
    end
  end
end
