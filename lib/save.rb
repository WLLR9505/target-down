require "open-uri"

module SaveFile
    def SaveFile.writeMedia(url, file)
        puts("saving #{file}...")
        open(file, "wb") do |file| 
        file.print open(url).read
        end
    end
end

