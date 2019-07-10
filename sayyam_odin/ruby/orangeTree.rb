class OrangeTree

    def initialize name
        @name = name
        @treeHeight = 1
        @treeAge = 0
        @orangeCount = 0

        puts @name + " is born"
    end

    def height 
        puts @name + " height is " + @treeHeight.to_s + " metre"
    end

    def countTheOranges
        puts "There are " + @orangeCount.to_s + " oranges on the " + @name
    end

    def pickAnOrange
        if @orangeCount > 0
            puts "The orange was delicious"
            @orangeCount = @orangeCount - 1
        else
            puts "There are no oranges on the tree"
        end
    end


    

    def oneYearPasses
        @treeAge = @treeAge + 1
        @treeHeight = @treeHeight + 2
        @orangeCount = 0

        if @treeAge >= 3 && @treeAge < 4
            @orangeCount = @orangeCount + 1

        elsif @treeAge >= 4 && @treeAge < 5
            @orangeCount = @orangeCount + 2

        elsif @treeAge >= 5 && @treeAge < 6
            @orangeCount = @orangeCount + 3

        elsif @treeAge > 6
            puts "Sorry, The " + @name + " is dead"
            exit
        end
    end
end


    tree = OrangeTree.new "saffron"
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.pickAnOrange
    tree.oneYearPasses
    tree.height
    tree.countTheOranges
    tree.pickAnOrange
    tree.pickAnOrange



