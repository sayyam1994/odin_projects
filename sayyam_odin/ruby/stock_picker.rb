stock_prices = [17,3,6,9,15,8,6,1,10]

def stock_picker(arr)
    len = arr.length
    #i = 0
    #j = 1
    temp = 0
    best = 0
    for i in 0..len-1
        for j in i+1..len-1
            temp = arr[j] - arr[i]
            if temp > best
                best = temp
                buying_price = i
                selling_price = j
            end
        end
    end
    puts "Buying price is #{arr[buying_price]} and Selling price is #{arr[selling_price]} and Profit is #{best}"
end

stock_picker(stock_prices)