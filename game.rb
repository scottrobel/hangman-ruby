def create_valid_words_file
    text_file = File.open("5desk.txt")
    valid_words = File.open("valid_words.txt", "w+")
    if(!File.exist?("valid_words.txt"))
        while !text_file.eof?
            word = text_file.readline
            word_length = word.chomp.length
            valid_words.write(word) if(word_length <= 12 && word_length >= 5)
        end
        puts "file created"
    end
    puts valid_words[3]
end