def merge_sort(arr)
    n = arr.length
    arr_A = arr[0..n/2-1]
    arr_B = arr[n/2..n-1] 
    if n < 2
        return arr
    else
       leftside = merge_sort(arr_A)
       rightside = merge_sort(arr_B)
       merge(leftside,rightside)
    end
end

def merge(arr_A,arr_B)
    sorted_arr = []
    while (arr_A != [] && arr_B != []) do
        if arr_A[0] > arr_B[0]
            sorted_arr << arr_B.shift
        else
            sorted_arr << arr_A.shift
        end
        print sorted_arr
        puts ""
    end

    while arr_A != [] do
        sorted_arr << arr_A.shift
    end

    while arr_B != [] do
        sorted_arr << arr_B.shift
    end

    sorted_arr
end

arr = [20,55,43,67,21,9,68,102]
print merge_sort(arr)