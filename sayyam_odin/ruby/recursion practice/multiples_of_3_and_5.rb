def multiple(num,sum=0,i=1)
    if i >= num
        return sum
    else
        if is_multiple_of_3?(i) || is_multiple_of_5?(i)
            sum = sum + i
        end
        i += 1
        multiple(num,sum,i)
    end
end

def is_multiple_of_3?(x)
    if x % 3 == 0
        return true
    end
end

def is_multiple_of_5?(x)
    if x % 5 == 0
        return true
    end
end

puts multiple(1000)