require "colorize"
require "http/server"

port = 8080

server = HTTP::Server.new(port) do |context|
  context.response.content_type = "text/html"
  context.response.print(File.read("/Users/ray/Code/md_spa/examples/index.html"))
end

puts("Listening on #{"http://localhost:#{port}".colorize.green}.")
server.listen
