def even_fibonacci_sum(num,i=1,j=2,next_number=0,sum = 0)
    if next_number >= num
        return sum
    else
        next_number = i + j
        i = j
        j = next_number
        sum = sum + next_number if next_number % 2 == 0
        even_fibonacci_sum(num,i,j,next_number,sum)
    end
end

puts even_fibonacci_sum(4000000)