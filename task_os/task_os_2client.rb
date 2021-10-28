require "socket"

socket = UNIXSocket.new('/tmp/socket')
socket.write("ping | sent from child (#{$$})\n")
puts socket.readline
socket.close
