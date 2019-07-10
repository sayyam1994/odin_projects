puts "Enter the string to be encrypted"
str = gets.chomp
puts "Enter the shift index"
index = gets.chomp.to_i
#puts str.each_byte.to_a
def caesarCipher(str,index)
    i = 0
    arr = str.each_byte.to_a

    arr.each do
        if arr[i] >= 65 && arr[i] <123
            if ((arr[i] + index) > 90 && (arr[i] + index) < 97)
                diff = index - (90 - arr[i])
                arr[i] = diff + 65 - 1
            elsif ((arr[i] + index) > 122)
                diff = index - (122 - arr[i])
                arr[i] = diff + 97 - 1
            else
                arr[i] = arr[i] + index
            end
        end
        arr[i] = arr[i].chr 
        i += 1
    end
    puts arr.join
end

caesarCipher(str,index)