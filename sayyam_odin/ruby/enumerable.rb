module Enumerable

    def my_each
        for i in 0..self.length-1
            yield(self[i])
        end
    end

    def my_each_with_index
        for i in 0..self.length-1
            yield(i,self[i])
        end
    end

    def my_select
        temp = []
        self.my_each {|x| temp << x if yield x}
        temp
    end

    def my_any?
        check = false
        self.my_each {|x| check = true if yield x }
        puts check
    end

    def my_all?
        check = 0
        self.my_each {|x| check += 1 if yield x}
        if check == self.length
            puts true
        else
            puts false
        end
    end

    def my_none?
        check = 0
        self.my_each {|x| check += 1 if yield x}
        if check == 0
            puts true
        else
            puts false
        end
    end

    def my_count
        count = 0
        self.my_each{|x| count += 1 if yield x}
        puts count
    end

    def my_map(add)
        result = []
        
        self.my_each{|x| result << add.call(x)}
        puts result
    end

end

arr = ["yo","man","what","is","going","on"]
num = [1,2,3,4,5,6]

arr.my_each {|x| puts x}

arr.my_each_with_index {|x,y| puts "the list is #{y} with index #{x}"}

num.my_select {|x| x > 3}

num.my_any? {|x| x > 8}

num.my_all? {|x| x > 0}

num.my_none? {|x| x > 9}

num.my_count {|x| x > 2}

add = Proc.new {|x| x + 100}

num.my_map(add)



