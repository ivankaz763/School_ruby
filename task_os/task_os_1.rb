ppid = Process.pid
child_pid = fork do
    Signal.trap("USR1") do
        $stdout.syswrite("Hello world! sent from child process #{$$}\n")
        Process.kill("USR2", ppid)
        exit
    end
end
  
Signal.trap("USR2") do 
    $stdout.syswrite("Bye) sent from parent process #{$$}\n")
end
  
Process.kill("USR1", child_pid)
  
Process.wait(child_pid)

puts "The PID of the parent process is #{ppid}"
puts "The PID of the child process is #{child_pid}"
