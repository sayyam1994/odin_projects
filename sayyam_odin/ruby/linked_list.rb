class Node
    attr_accessor :value, :next_node
    def initialize(value)
        @value = value
        @next_node = nil
    end
end


class LinkedList
    attr_accessor :head, :tail, :size
    def initialize
        @head = nil
        @tail = nil
        @size = 0
    end

    def append(value)
		node = Node.new(value)
		@head ? (@tail.next_node = node) : (@head = node)
		@tail = node
        @size += 1
    end

    def to_s
        output = ''
        if @head == nil
          output = 'nil'
        else
          node = @head
          output += "(#{node.value})-> "
          until output.include?('nil') do
            node = node.next_node
            output += "(#{node.value})-> "
            output += "nil" if node.next_node== nil
          end
        end
        puts output.value
    end
    
end


 list = LinkedList.new



 ("a".."z").each do |char|
   node = Node.new char
   list.append(Node.new(char))
 end

 puts "Printing the alphabet..."

 puts list.to_s
