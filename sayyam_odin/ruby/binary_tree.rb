class Node
    attr_accessor :value, :parent, :left_child, :right_child
    def initialize(value,parent=nil)
        @value = value
        @parent = parent
        @left_child = nil
        @right_child = nil
    end
end

class BinaryTree
    attr_accessor :root

    def initialize
      @root = nil
    end

    def build_tree(arr)
        @root = Node.new(arr.shift)
        arr.each do |value|
            add_node(value, @root)
        end
    end

    def add_node(value, parent)
        child = Node.new(value, parent)

        if parent.value >= value && parent.left_child == nil
            parent.left_child = child
           # print "parent element #{parent.value}   "
            #puts "left_child #{child.value}"
        elsif parent.value < value && parent.right_child == nil
            #print "parent element #{parent.value}   "
            parent.right_child = child
            #puts "right_child #{child.value}"
        else
            parent.value >= value ? add_node(value, parent.left_child) : add_node(value, parent.right_child) 
        end
    end

    def breadth_first_search(target)
        queue = [@root]
        
        until queue.empty?
            current = queue.shift
            return current if current.value == target
            queue << current.left_child unless current.left_child.nil?
            queue << current.right_child unless current.right_child.nil?
        end
        "Value doesn't exist in the tree"
    end

    def depth_first_search(target, current=@root)
        return current if current.nil? || current.value == target 
        temps = depth_first_search(target, current.left_child)
        temps = depth_first_search(target, current.right_child) if temps.nil?
        temps
    end

end

arr = [10, 5, 20, 6, 50, 15, 4]
tree = BinaryTree.new
tree.build_tree(arr)
puts tree.depth_first_search(20)
