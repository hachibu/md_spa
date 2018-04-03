require "../spec_helper"
require "tempfile"

describe MdSpa::CLI do
  describe ".run" do
    it "compiles a Markdown file to an HTML file" do
      Tempfile.open("test") do |file|
        MdSpa::CLI.run(file.path)

        html_path = File.join(
          File.dirname(file.path),
          File.basename(file.path, ".md") + ".html"
        )

        File.exists?(html_path).should eq(true)
        File.read(html_path).should eq(
          "<!DOCTYPE html><html><head></head><body></body></html>"
        )
      end
    end
  end
end
