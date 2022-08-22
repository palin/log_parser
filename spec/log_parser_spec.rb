# frozen_string_literal: true

RSpec.context 'LogParser - integration' do
  context 'full execution with valid input' do
    let(:executable) { './log_parser.rb' }
    let(:log_file_path) { "log_#{Time.now.to_i}.log" }
    let(:log_content) { log_lines_example }

    before { create_file(log_file_path, log_content) }

    after { delete_file(log_file_path) }

    subject { `#{executable} #{log_file_path}` }

    it 'accepts input, parses and produces output' do
      expect(subject).to eq(
        ''"Finished parsing file: #{log_file_path}
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
"''
      )
    end
  end
end
