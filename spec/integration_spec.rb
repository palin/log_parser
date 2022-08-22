RSpec.context "Integration" do

  context "full execution with valid input" do
    let(:executable) { "./log_parser.rb" }
    let(:log_file) { "./logs/webserver.log" }
    let(:test_log_file_path) { "log_#{Time.now.to_i}.log"}
    let(:log_content) do
      "
      /help_page/1 126.318.035.038
      /contact 184.123.665.067
      /home 184.123.665.067
      /about/2 444.701.448.104
      /help_page/1 929.398.951.889
      /index 444.701.448.104
      /help_page/1 722.247.931.582
      /about 061.945.150.735
      /help_page/1 646.865.545.408
      /home 235.313.352.950
      /contact 184.123.665.067
      /help_page/1 543.910.244.929
      /home 316.433.849.805
      /about/2 444.701.448.104
      /contact 543.910.244.929
      /about 126.318.035.038
      /about/2 836.973.694.403
      /index 316.433.849.805
      /index 802.683.925.780
      /help_page/1 929.398.951.889
      /contact 555.576.836.194
      /about/2 184.123.665.067
      /home 444.701.448.104
      /index 929.398.951.889
      /about 235.313.352.950
      /contact 200.017.277.774
      /about 836.973.694.403
      /contact 316.433.849.805
      /help_page/1 929.398.951.889
      /about/2 382.335.626.855
      /home 336.284.013.698
      /about 929.398.951.889
      /help_page/1 836.973.694.403
      /contact 836.973.694.403
      /home 444.701.448.104
      /about/2 543.910.244.929
      /about 715.156.286.412
      "
    end

    before do
      File.open(test_log_file_path, "w+") { |file| file.write(log_content) }
    end

    after do
      File.delete(test_log_file_path) if File.exist?(test_log_file_path)
    end

    it "accepts input, parses and produces output" do
      cmd = `#{executable} #{test_log_file_path}`

      expect(cmd).to eq(
"""Finished parsing file: #{test_log_file_path}
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
---
"""
      )
    end
  end
end
