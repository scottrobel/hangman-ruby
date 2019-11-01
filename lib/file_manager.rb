class FileManager
    def self.create_valid_words_file
        text_file = File.open("../words/5desk.txt")
        if(!File.exist?("../words/valid_words.txt"))
            valid_words = File.open("../words/valid_words.txt", "w+")
            while !text_file.eof?
                word = text_file.readline
                word_length = word.chomp.length
                valid_words.write(word) if(word_length <= 12 && word_length >= 5)
            end
            puts "file created"
        end
    end
end 