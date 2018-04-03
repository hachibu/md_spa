require "html_builder"
require "markd"

class MdSpa::MarkdownParser
  alias CodeBlock = {
    language: String,
    text: String
  }

  def initialize(text : String)
    @codeblocks = [] of CodeBlock

    document = Markd::Parser.parse(text)
    walk_document(document) do |node|
      case node.type
      when Markd::Node::Type::CodeBlock
        @codeblocks << CodeBlock.new(
          language: node.fence_language,
          text: node.text.strip
        )
      end
    end
  end

  def to_html
    HTML.build do
      doctype
      html do
        head do
          tag("style", type: "text/css") do
            codeblocks("css").each do |cb|
              html(cb[:text])
            end
          end
        end

        body do
          codeblocks("html").each do |cb|
            html(cb[:text])
          end

          tag("script", type: "text/javascript") do
            codeblocks("javascript").each do |cb|
              html(cb[:text])
            end
          end
        end
      end
    end
  end

  def codeblocks(language : String = nil)
    if language.nil?
      @codeblocks
    else
      @codeblocks.select { |cb| cb[:language] == language }
    end
  end

  private def walk_document(document)
    walker = document.walker
    while event = walker.next
      node, _ = event
      yield node
    end
  end
end
