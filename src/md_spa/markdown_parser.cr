require "html_builder"
require "markd"

class MdSpa::MarkdownParser
  alias CodeBlock = {
    language: String,
    code: String
  }

  @document : Markd::Node

  def initialize(text : String)
    @codeblocks = [] of CodeBlock
    @document = Markd::Parser.parse(text)

    each_node do |node|
      case node.type
      when Markd::Node::Type::CodeBlock
        @codeblocks << CodeBlock.new(
          language: node.fence_language,
          code: node.text.strip
        )
      end
    end
  end

  def codeblocks(language : String? = nil)
    if language.nil?
      @codeblocks
    else
      @codeblocks.select { |cb| cb[:language] == language }
    end
  end

  def to_html
    HTML.build do
      doctype
      html do
        head do
          codeblocks("css").each do |cb|
            tag("style", type: "text/css") do
              html(cb[:code])
            end
          end
        end

        body do
          codeblocks("html").each do |cb|
            html(cb[:code])
          end

          codeblocks("javascript").each do |cb|
            tag("script", type: "text/javascript") do
              html(cb[:code])
            end
          end
        end
      end
    end
  end

  def each_node
    walker = @document.walker
    while event = walker.next
      node, _ = event
      yield node
    end
  end
end
