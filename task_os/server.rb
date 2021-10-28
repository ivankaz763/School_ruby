require "socket"

server = UNIXServer.new('/tmp/socket')
socket = server.accept
puts socket.readline
socket.write("pong | sent from parent (#{$$})\n")
socket.close