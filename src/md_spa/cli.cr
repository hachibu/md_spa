require "admiral"
require "colorize"
require "watcher"

class MdSpa::CLI < Admiral::Command
  define_version(MdSpa::VERSION)
  define_help(description: "Compile a Markdown file into an HTML file or an executable.")

  define_argument(
    input : String,
    description: "Path to Markdown file.",
    required: true
  )

  define_flag(
    build : String,
    description: "Build an HTML file or an executable.",
    default: "html"
  )
  define_flag(
    serve : Bool,
    description: "Serve and watch Markdown file for changes.",
    default: false
  )

  def run : Nil
    input = parse_input_argument!
    build = parse_build_flag!

    if flags.serve
      serve_and_watch(input)
    else
      case build
      when "html"
        compile_index_md(input)
      when "exe"
        compile_index_md(input)
        compile_index_cr(input, :static)
        compile_index_exe(input)
      end
    end
  end

  def serve_and_watch(input)
    spawn do
      puts "Watching #{input.colorize.green}."
      watch input do |event|
        event.on_change do
          compile_index_md(input)
        end
      end
    end

    spawn do
      exe_file = change_file_extension(input, ".md", ".exe")

      compile_index_cr(input, :dynamic)
      compile_index_exe(input)

      system(exe_file)
    end

    sleep
  end

  def compile_index_md(input : String) : Nil
    md_file = input
    html_file = change_file_extension(input, ".md", ".html")

    puts("Compiling Markdown to HTML: #{html_file.colorize.green}.")

    md = MdSpa::MarkdownParser.new(File.read(md_file))
    html = md.to_html

    File.write(html_file, html)
  end

  def compile_index_cr(input : String, mode : Symbol) : Nil
    html_file = change_file_extension(input, ".md", ".html")
    cr_file = change_file_extension(input, ".md", ".cr")

    if mode != :dynamic && mode != :static
      error("Mode is invalid: #{mode}. Expecting dynamic or static.")
    end

    cr = MdSpa::ServerTemplate.new(html_file: html_file, mode: mode).to_s

    puts("Compiling HTML to #{mode.to_s.capitalize} Crystal Server: #{cr_file.colorize.green}.")

    File.write(cr_file, cr)
  end

  def compile_index_exe(input : String) : Nil
    cr_file = change_file_extension(input, ".md", ".cr")
    exe_file = change_file_extension(input, ".md", ".exe")

    puts("Compiling Crystal Server to Executable: #{exe_file.colorize.green}.")

    system("crystal build #{cr_file} -o #{exe_file} --error-trace")
  end

  def change_file_extension(file : String, old_extension : String, new_extension : String) : String
    File.join(
      File.dirname(file),
      File.basename(file, old_extension) + new_extension
    )
  end

  def parse_input_argument! : String
    input = arguments.input
    unless File.exists?(input)
      error("Input file does not exist: #{input}.")
    end
    input
  end

  def parse_build_flag! : String
    build = flags.build
    if build != "exe" && build != "html"
      error("Build flag is invalid: #{build}. Expecting html or exe.")
    end
    build
  end

  def error(message) : Nil
    puts(message.colorize.red)
    exit(1)
  end
end
