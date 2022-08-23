# frozen_string_literal: true

describe LogParser::Core do
  include TestHelper

  describe '.run' do
    let(:log_file_path) { "log_#{Time.now.to_i}.log" }

    before { create_file(log_file_path, log_content) }

    after { delete_file(log_file_path) }

    subject { described_class.run(log_file_path) }

    context 'log with single page' do
      let(:log_content) { '/help_page/1 126.318.035.038' }

      it 'returns hash with a single result' do
        expect(subject).to eq(
          {
            regular: [
              ['/help_page/1', 1]
            ],
            unique: [
              ['/help_page/1', 1]
            ]
          }
        )
      end
    end

    context 'log with many pages' do
      let(:log_content) { log_lines_example }

      it 'creates an array of hashes with parsed results' do
        expect(subject).to eq(
          {
            regular: [
              ['/help_page/1', 8],
              ['/contact', 7],
              ['/about', 6],
              ['/about/2', 6],
              ['/home', 6],
              ['/index', 4]
            ],
            unique: [
              ['/about', 6],
              ['/contact', 6],
              ['/help_page/1', 6],
              ['/about/2', 5],
              ['/home', 5],
              ['/index', 4]
            ]
          }
        )
      end
    end

    context 'sorting' do
      let(:log_content) do
        '/help_page/1 126.318.035.038
        /about 2.3.4.5
        /contact 1.2.3.4
        /about 2.3.4.6
        /help_page/1 126.318.035.038
        /help_page/1 126.318.035.038'
      end

      it 'returns hash with a single result' do
        expect(subject).to eq(
          {
            regular: [
              ['/help_page/1', 3],
              ['/about', 2],
              ['/contact', 1]
            ],
            unique: [
              ['/about', 2],
              ['/contact', 1],
              ['/help_page/1', 1]
            ]
          }
        )
      end
    end
  end
end
