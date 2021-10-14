require 'socket'

parent_socket, child_socket = UNIXSocket.pair
ppid = Process.pid
child_pid = fork do
    while(1)
        child_socket.send("ping | sent from child (#{$$})", 0)
        puts child_socket.recv(100)
    end
  parent_socket.close
end

num_of_hit = 0

while (num_of_hit < 10)
    parent_socket.send("pong | sent from parent (#{$$})", 0)
    puts parent_socket.recv(100)
    sleep(0.1)
    num_of_hit += 1
end

child_socket.close

puts "The PID of the parent process is #{ppid}"
puts "The PID of the child process is #{child_pid}"