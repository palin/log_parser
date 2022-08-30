# frozen_string_literal: true

describe LogParser::Validator do
  describe '.run' do
    let(:filename) { 'example.log' }

    subject { described_class.run(filename) }

    context 'invalid file' do
      context "file doesn't exist" do
        before do
          allow(LogParser::Validator::Existence).to receive(:check).and_raise(StandardError.new('no file!'))
          allow(LogParser::Validator::Emptiness).to receive(:check).and_return(true)
        end

        it 'raises an error' do
          expect { subject }.to raise_error(StandardError)
        end
      end

      context 'file is empty' do
        before do
          allow(LogParser::Validator::Existence).to receive(:check).and_return(true)
          allow(LogParser::Validator::Emptiness).to receive(:check).and_raise(StandardError.new('empty!'))
        end

        it 'raises an error' do
          expect { subject }.to raise_error(StandardError)
        end
      end
    end

    context 'valid file' do
      before do
        allow(LogParser::Validator::Existence).to receive(:check).and_return(true)
        allow(LogParser::Validator::Emptiness).to receive(:check).and_return(true)
      end

      it "doesn't raise errors" do
        expect { subject }.not_to raise_error
      end
    end
  end
end
