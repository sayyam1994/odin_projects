def grandFatherClock &block
    currentTime = gets.chomp.to_i

    if currentTime >=13 && currentTime <=23
        currentTime = currentTime - 12
    end

    self.each do |letter|
        block.call letter
  
    end

end

["A","B","C","D"].grandFatherClock do |letter|
    puts "DONG!"
end
