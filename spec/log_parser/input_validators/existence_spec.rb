require_relative '../../../log_parser/input_validators/existence'

RSpec.describe LogParser::InputValidators::Existence do
  describe '.check' do
    subject { described_class.check(file) }

    context "file doesn't exist" do
      let(:file) { 'blah.log' }

      it 'throws an exception' do
        expect { subject }.to raise_error(Errno::ENOENT)
      end
    end

    context 'file exists' do
      let(:file) { './logs/webserver.log' }

      it 'returns an instance of a File' do
        expect(subject).to be_kind_of(File)
      end
    end
  end
end
