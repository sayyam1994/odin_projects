puts "Enter a number"
num = gets.chomp.to_i

def fibs(num)
    j = 0
    sum = 1
    for i in 0..num do
        ans = sum + j
        j = sum
        sum = ans
        print "#{ans} "
    end
end

def fibs_rec(num)
    num > 2 ? fibs_rec(num-1) + fibs_rec(num-2) : num
    #puts num
end

puts fibs_rec(num)

