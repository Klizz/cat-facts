# http_server.rb
require 'socket'
server = TCPServer.new 5678

require 'net/http'
require 'json'

key = "68db822c-1fce-4432-ab1b-fb7457d37562"

url = 'https://api.thecatapi.com/v1/images/search'
uri = URI(url)
response = Net::HTTP.get(uri)
body = JSON.parse(response)
puts body[0]["url"]

while session = server.accept
  request = session.gets
  puts request

  session.print "HTTP/1.1 200\r\n" # 1
  session.print "Content-Type: json\r\n" # 2
  session.print "\r\n" # 3
  session.print body[0]["url"] #4

  session.close
end