require "../spec_helper"

describe MdSpa::MarkdownParser do
  describe "#codeblocks" do
    it "returns all codeblocks" do
      markdown_parser = create_markdown_parser

      markdown_parser.codeblocks.size.should eq(3)
    end

    it "returns codeblocks by language" do
      markdown_parser = create_markdown_parser

      %w(css html javascript).each do |language|
        markdown_parser.codeblocks(language: language).size.should eq(1)
      end
    end
  end

  describe "#to_html" do
    it "" do
      markdown_parser = create_markdown_parser

      markdown_parser.to_html.should eq(
        "<!DOCTYPE html><html><head><style type=\"text/css\">body { background: red; }</style></head><body><p>hello</p><script type=\"text/javascript\">console.log('world');</script></body></html>"
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
