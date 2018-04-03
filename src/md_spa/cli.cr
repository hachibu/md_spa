require "admiral"
require "watcher"

class MdSpa::CLI < Admiral::Command
  define_version(
    MdSpa::VERSION,
    short: v
  )
  define_help(
    description: "Compile a Markdown file into a single HTML file.",
    short: h
  )
  define_argument(
    input : String,
    description: "Path to Markdown file.",
    required: true
  )
  define_flag(
    output : String,
    description: "Path to HTML file.",
    short: o
  )
  define_flag(
    watch : Bool,
    default: false,
    description: "Watch Markdown file for changes.",
    short: w
  )

  def run : Nil
    input = parse_input_argument!
    output = parse_output_flag!(input)

    compile(input, output)

    return unless flags.watch

    puts "Watching #{input} for changes"
    watch input do |event|
      event.on_change do
        puts "Recompiling #{input}"
        compile(input, output)
      end
    end
  end

  def compile(input, output)
    markdown = MdSpa::MarkdownParser.new(File.read(input))
    File.write(output, markdown.to_html)
  end

  def parse_input_argument! : String
    input = arguments.input

    unless File.exists?(input)
      error("input does not exist: #{input}")
    end

    input
  end

  def parse_output_flag!(input) : String
    flags.output || File.join(
      File.dirname(input),
      File.basename(input, ".md") + ".html"
    )
  end

  def error(message) : Nil
    puts(message)
    exit(1)
  end
end
