require 'net_http_ssl_fix'
require 'net/http'
require 'json'
require 'uri'

require_relative './lib/ig.rb'
require_relative './lib/vsco.rb'
require_relative './lib/tt.rb'
require_relative './lib/save.rb'

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
        print("  #{i + 1}/#{downloadList.length}  ")
        if downloadList[i][1] == 'image'
            SaveFile.writeMedia(downloadList[i][0], "./media/#{$filename}_#{Time.now.strftime("%d%m%Y%H%M%S%L")}.jpg")
        else
            SaveFile.writeMedia(downloadList[i][0], "./media/#{$filename}_#{Time.now.strftime("%d%m%Y%H%M%S%L")}.mp4")
        end
        print("\r")
    end
end

def check_dir(directory)
    if !Dir.exists?(directory)
        puts 'creating ./media'
        Dir.mkdir('./media')
    end
end

def check_url(url)
    if url.include? 'tiktok' or url.include? 'vsco' or url.include? 'instagram'
        return true
    else
        return false
    end
end

def main()
    check_dir('./media')
    loop do
        puts "Paste a URL (ENTER to exit)"
        url = gets.strip
        break if !url.include? 'http'
        
        if check_url(url)
            uri = URI(url)
            body = Net::HTTP.get(uri)
            
            #puts body
        
            findLinks(url, body)
            download($toDownload)
        else
            puts "ERROR :: Invalid URL, try again"
        end
    end
end

main()
