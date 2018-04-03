require "admiral"

class MdSpa::CLI < Admiral::Command
  define_version MdSpa::VERSION,
                 short: v
  define_help description: "Compile a Markdown file into a single HTML file.",
              short: h
  define_argument input : String,
                  description: "Path to Markdown file.",
                  required: true
  define_flag output : String,
              short: o

  def run
    input = parse_input_argument!
    output = parse_output_flag!(input)
    markdown = MdSpa::MarkdownParser.new(File.read(input))

    File.write(output, markdown.to_html)
  end

  def parse_input_argument!
    input = arguments.input

    unless File.exists?(input)
      error("input does not exist: #{input}")
    end

    input
  end

  def parse_output_flag!(input)
    flags.output || File.join(
      File.dirname(input),
      File.basename(input, ".md") + ".html"
    )
  end

  private def error(message)
    puts(message)
    exit(1)
  end
end
