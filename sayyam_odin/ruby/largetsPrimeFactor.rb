puts "Enter a number to find its prime factors"
num = gets.chomp.to_i

while num % 2 == 0
    num = num / 2
    puts 2
end

sqrt = Math.sqrt(num).to_i

for i in (3...sqrt).step(2) do
    puts i
    while num % i == 0
        num = num / i
        puts i
    end
end



