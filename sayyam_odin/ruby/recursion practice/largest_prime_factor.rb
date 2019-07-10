def largest_prime_factor(num,i=3,maxPrime=0)
    if num == 1
        return maxPrime
    else
        if num % 2 == 0
            num = num/2
            puts num
            maxPrime = 2
        elsif num % 3 == 0
            num = num/3
            puts num
            maxPrime = 3
        else
            i = i + 2
            if num % i == 0
                num = num/i
                puts num
                maxPrime = i
            end
        end
        largest_prime_factor(num,i,maxPrime)
    end
end

puts largest_prime_factor(60080043)