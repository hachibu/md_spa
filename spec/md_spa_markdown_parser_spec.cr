require "./spec_helper"

def codeblock(language, code)
  "```#{language}\n" + code + "\n```\n"
end

def create_markdown_parser
  MdSpa::MarkdownParser.new(
    codeblock("css", "body { background: red; }") +
    codeblock("html", "<p>hello</p>") +
    codeblock("js", "console.log('world');")
  )
end

describe MdSpa::MarkdownParser do
  describe "#codeblocks" do
    it "returns all codeblocks" do
      markdown_parser = create_markdown_parser

      markdown_parser.codeblocks.size.should eq(3)
    end

    it "returns codeblocks by language" do
      markdown_parser = create_markdown_parser

      %w(css html js).each do |language|
        markdown_parser.codeblocks(language: language).size.should eq(1)
      end
    end
  end

  describe "#to_html" do
    it "" do
      markdown_parser = create_markdown_parser

      markdown_parser.to_html.should eq(
        "<!DOCTYPE html><html><head><style type=\"text/css\">body { background: red; }</style></head><body><p>hello</p><script type=\"text/javascript\"></script></body></html>"
      )
    end
  end

  describe "#each_node" do
    it "traverses each node" do
      markdown_parser = create_markdown_parser
      nodes = [] of Markd::Node

      markdown_parser.each_node do |node|
        nodes << node
      end

      nodes.size.should eq(5)
    end
  end
end
