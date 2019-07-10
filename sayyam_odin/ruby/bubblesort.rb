def bubble_sort_by(arr)
    len = arr.length

    len.times do
    for i in 0..len-2
        result = yield(arr[i],arr[i+1])

        if result > 0
            temp = arr[i+1]
            arr[i+1] = arr[i]
            arr[i] = temp
        end
    end
    end
    arr
end

my_array = ["yoman", "hi", "hello", "hey", "what"]

bubble_sort_by(my_array){|left, right| left.length - right.length}

puts my_array