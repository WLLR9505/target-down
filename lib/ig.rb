module IG
    def IG.down(body)
        first = 0
        toDownload = []

        loop do ##loop for photos
            first = body.index('"display_url":"', first + 15)
            break if first.nil? == true

            urlMedia = body.slice(first + 15, first + 500)
            last = urlMedia.index('"')
            urlMedia = urlMedia.slice(0, last)

            urlMedia = urlMedia.gsub('\u0026', '&')

            toDownload.push([urlMedia, 'image'])
        end
        first = 0
        loop do #loop for videos
            first = body.index('"video_url":"', first + 13)
            break if first.nil? == true

            urlMedia = body.slice(first + 13, first + 500)
            last = urlMedia.index('"')
            urlMedia = urlMedia.slice(0, last)

            urlMedia = urlMedia.gsub('\u0026', '&')

            toDownload.push([urlMedia, 'video'])
        end
        return toDownload.uniq
    end
end