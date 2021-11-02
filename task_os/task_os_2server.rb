require "socket"

File.delete('socket') if File.exists? 'socket'
server = UNIXServer.new('socket')
socket = server.accept
loop do
    puts socket.readline
    sleep 1
    puts '____________'
    socket.write("pong | sent from parent (#{$$})\n")
end
socket.close
