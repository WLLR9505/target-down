require "open-uri"

module SaveFile
    def SaveFile.writeMedia(url, file)
        print(" saving  #{file}         ")
        print("\r")
        open(file, "wb") do |file| 
        file.print open(url).read
        end
        print(" saved  #{file}          \n")
    end
end

