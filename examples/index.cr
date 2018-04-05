require "colorize"
require "http/server"
require "option_parser"

port = 8080

OptionParser.parse! do |parser|
  parser.on("-h", "--help", "Show help.") do
    puts parser
  end
  parser.on("-p PORT", "--port=PORT", "Specify port to listen on.") do |p|
    port = p.to_i
  end
end

server = HTTP::Server.new(port) do |context|
  context.response.content_type = "text/html"
  context.response.print(%(<!DOCTYPE html><html><head><style type="text/css">body {
  align-items: center;
  background: white;
  display: flex;
  font-family: sans-serif;
  height: 100vh;
  justify-content: center;
}</style></head><body><script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/16.3.1/umd/react.production.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react-dom/16.3.1/umd/react-dom.production.min.js"></script>

<div id="root"></div><script type="text/javascript">ReactDOM.render(
  React.createElement('h1', null, 'Hello, world!'),
  document.getElementById('root')
);</script></body></html>))
end

puts("Listening on #{"http://localhost:#{port}".colorize.green}.")

server.listen
