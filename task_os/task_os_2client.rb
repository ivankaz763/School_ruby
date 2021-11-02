require "socket"

socket = UNIXSocket.new('socket')
loop do 
    socket.write("ping | sent from child (#{$$})\n")
    puts '____________'
    puts socket.readline
end
socket.close
