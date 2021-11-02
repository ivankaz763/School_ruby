RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

#  обычная рекурсия 
def factorial (num)
    if num < 0 
        puts "negativ argument"
    elsif num == 0
        1
    else 
        factorial(num - 1) * num 
    end
end 

# рекурсия с хвостовой оптимизацией
def tail_call_factorial(num, accumulator = 1)
    puts "negativ argument" if num < 0
    return accumulator if num == 0
    return tail_call_factorial(num - 1, accumulator * num)
  end

puts factorial(10000).to_s.size
puts tail_call_factorial(100000).to_s.size
