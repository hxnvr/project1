require 'socket'
require_relative 'request_parser'
require_relative 'response_builder'
require_relative 'response'
server  = TCPServer.new('localhost', 5678)

loop do
  client = server.accept
  request = client.readpartial(2048)

  parsed_request = RequestParser.new.parse(
    request: request
  )
  response = ResponseBuilder.new.build_response(
    request: parsed_request
  )

  response.send(client)
  
  client.close
end
