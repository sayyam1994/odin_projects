dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts "Enter a string"
str = gets.chomp.downcase




def substrings(str,dictionary)

str_arr = str.split(" ")
str_hash = Hash.new

    dictionary.each do |x|
        count = 0

        for i in 0..str_arr.length-1
            if str_arr[i].include? x
                count += 1
            end
        end

        if count > 0 
            str_hash[x] = count
        end
    end
    puts str_hash
end

substrings(str,dictionary)