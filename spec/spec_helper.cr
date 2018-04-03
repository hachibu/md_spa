require "spec"
require "../src/md_spa/*"

def codeblock(language, code)
  "```#{language}\n" + code + "\n```\n"
end

def create_markdown_parser
  MdSpa::MarkdownParser.new(
    codeblock("css", "body { background: red; }") +
    codeblock("html", "<p>hello</p>") +
    codeblock("javascript", "console.log('world');")
  )
end
