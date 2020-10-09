# http_server.rb
require 'socket'
server = TCPServer.new 5678

require 'net/http'
require 'json'

url = 'https://cat-fact.herokuapp.com/facts/random'
uri = URI(url)
response = Net::HTTP.get(uri)
body = JSON.parse(response)
puts body["text"]

while session = server.accept
  request = session.gets
  puts request

  session.print "HTTP/1.1 200\r\n" # 1
  session.print "Content-Type: json\r\n" # 2
  session.print "\r\n" # 3
  session.print body["text"] #4

  session.close
end