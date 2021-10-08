class El

    attr_accessor :next, :data

    def initialize(data)
        @data = data
        @next = nil
    end 

    def to_s
         data.to_s
    end

end 

class List 
    def initialize
        @head = nil 
    end

    def append(data)
        if @head
            find_end.next = El.new(data)
        else 
            @head = El.new(data)
        end
    end

    def prepend(data)
        if @head == nil
            @haed = El.new(data)
        else
            curr_head = El.new(data)
            curr_head.next = @head
            @head = curr_head
        end
    end

    def find_end
        el = @head
        return el unless el.next
        while (el = el.next)
            return el unless el.next
        end
    end

    def print
        el = @head
        return puts "list is empty" if @head == nil
        puts el
        while (el = el.next)
          puts el
        end
    end

    def count 
        res = 1
        el = @head 
        return 0 if @head == nil
        while (el = el.next) do
            res += 1
        end
        return res
    end

    def insert(data, num)

        len = 1 
        el = @head
        while (el = el.next) do
            len += 1
        end
        puts len

        if @head == nil
            @head = El.new(data)
        elsif num < 0 or num > len 
            return puts "not valid index"
        elsif num == 0
            curr_head = El.new(data)
            curr_head.next = @head
            @head = curr_head
        else
            current = @head
            before_current = @head 
            index = num - 1
            index.times do 
                before_current = before_current.next
            end
            num.times do 
                current = current.next
            end
            this_el = El.new(data)
            after_current = before_current.next
            before_current.next = this_el
            this_el.next = after_current
        end
    end

    def get(num)
        count = 0
        current = @head 
        while current.next != nil and count != num
            current = current.next
            count += 1
        end
        if count = num 
            return current.data
        end
        return "not valid index"
    end

    def remove(num)
        count = 0
        after_current = @head
        while after_current.next != nil and count != num 
            current = after_current
            after_current = after_current.next
            count += 1
        end
        if count == num
            current.next = after_current.next
        end
        return "not valid index"
    end

end

# l = List.new

# puts "создали пустой список"
# l.print
# l.append("items 1")
# puts "добвили элемен 1"
# l.print
# l.append("items 2")
# puts "добвили элемен 2"
# l.print
# l.prepend("items 0")
# puts "добвили элемен 0 на первое место"
# l.print
# puts "добвили элемен 1.5 на второе место"
# l.insert("items 1.5", 2)
# l.print
# puts "значение элемена с индексом 2"
# puts l.get(2)
# puts "удалили второй элемент"
# l.remove(2)
# l.print
# puts "колличество"
# puts l.count
# puts "значение элемена с индексом 2"
# puts l.get(2)

l = List.new


l.append("items 1")
l.append("items 2")
l.prepend("items 0")
l.insert("items 1.5", 2)

puts l.get(2)




l.remove(2)
puts l.count
puts l.get(2)

