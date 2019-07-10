class Node
    attr_accessor :value, :parent, :child
    def initialize(value,parent=nil)
        @value = value
        @parent = parent
        @child = []
    end
end


class Board
    attr_accessor :root

    def initialize
        create_board
        @root = nil
    end

    def create_board
        @board = []
        (1..8).each do |x|
            (1..8).each do |y|
                @board << [x,y]
            end
        end
    end

    def build_tree(current_pos)
        i = 0
        parent = Node.new(current_pos)
        moves = valid_moves(current_pos)
        moves.each do |move|
            child = Node.new(move, parent)
            parent.child[i] = child
            puts "parent #{parent.value} child #{i} = #{parent.child[i].value}"
            i += 1
        end
        parent.child
    end

    def validate_input(start, target)
        (0..1).each do |i|
            unless (start[i].between?(1, 8) && target[i].between?(1, 8))
                exit
            end
        end
    end

    def valid_moves(current_pos)

        available_moves = []
        available_moves << [current_pos[0] + 2, current_pos[0] + 1] #two up and one right
        available_moves << [current_pos[0] + 2, current_pos[0] - 1] #two up and one left
        available_moves << [current_pos[0] - 2, current_pos[0] + 1] #two down and one right
        available_moves << [current_pos[0] - 2, current_pos[0] - 1] #two down and one left
        available_moves << [current_pos[0] + 1, current_pos[0] + 2] #one up and two right
        available_moves << [current_pos[0] + 1, current_pos[0] - 2] #one up and two left
        available_moves << [current_pos[0] - 1, current_pos[0] + 2] #one down and two right
        available_moves << [current_pos[0] - 1, current_pos[0] - 2] #one down and two left

        @valid_moves = []
        available_moves.each do |move|
            @valid_moves << move if @board.include?(move)
        end
        @valid_moves
        #print @valid_moves if validate_input(current_pos,target)
    end

    def knight_moves(current_pos,target,x=nil,route=[])
        validate_input(current_pos,target)
        @root = current_pos if @root.nil?
        x = build_tree(current_pos) if x.nil?
        for i in 0..x.length-1 do
            if x[i].value == target
                puts "found it"
                exit
            end
        end
        current_pos = x.shift.value
        knight_moves(current_pos,target,x,route)
    end

end

a = Board.new
a.knight_moves([4,4],[1,1])

