require 'benchmark'

ar_first = []
ar_second = []
Benchmark.bm do |x|
    x.report('sequential') do
      100000.times do
            ar_first.push(1)
      end
    end
  
    x.report('thready') do
      100000.times do
        Thread.new do
            ar_second.push(1)
        end
      end
    end
  end

print "number of items added sequential " 
puts ar_first.count 
print "number of items added thready " 
puts ar_second.count 
