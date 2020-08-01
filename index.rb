require 'net/http'
require 'json'
require 'uri'

require './lib/ig'
require './lib/vsco'
require './lib/tt'
require './lib/save'

# puts body

$toDownload = []
$filename = ''
def findLinks(url, body)
    if url.include? 'insta'
        $filename = "ig"
        $toDownload = IG.down(body)
    elsif url.include? 'vsco'
        $filename = "#{VSCO.filename(url)}_vsco"
        $toDownload = VSCO.down(body)
    elsif url.include? 'tiktok'
        $filename = "#{TT.filename(url)}_tiktok"
        $toDownload = TT.down(body)
    end
end

def download(downloadList)
    i = 0
    for i in (0...downloadList.length) do
        if downloadList[i][1] == 'image'
            SaveFile.writeMedia(downloadList[i][0], "./media/#{$filename}_#{Time.now.strftime("%d%m%Y%H%M%S%L")}.jpg")
        else
            SaveFile.writeMedia(downloadList[i][0], "./media/#{$filename}_#{Time.now.strftime("%d%m%Y%H%M%S%L")}.mp4")
        end
    end
end

def check_dir(directory)
    # puts Dir.exists?(directory)
    if !Dir.exists?(directory)
        puts 'creating ./media'
        Dir.mkdir('./media')
    end
end


def main()
    check_dir('./media')
    loop do
        puts "Paste a URL (invalid value to exit)"
        url = gets.strip

        break if !url.include? 'http'

        uri = URI(url)
        body = Net::HTTP.get(uri)
    
        findLinks(url, body)
        download($toDownload)
    end
end

main()
