module VSCO
    def VSCO.filename(url)
        first = url.index('co/') + 3
        last = url.index('/', first + 4)
        return url[first...last]
    end
    
    def VSCO.down(body)
        first = 0
        toDownload = []

        loop do ##loop for photos
            first = body.index('property="og:image" content="', first + 29)
            break if first.nil? == true

            urlMedia = body.slice(first + 29, first + 500)
            last = urlMedia.index('"')
            urlMedia = urlMedia.slice(0, last)

            urlMedia = urlMedia.gsub('\u0026', '&')

            urlMedia = urlMedia.gsub('//im.vsco.co/1/', '//image.vsco.co/1/')
            urlMedia = urlMedia.gsub('//im.vsco.co/aws-us-west-2/', '//image-aws-us-west-2.vsco.co/')

            toDownload.push([urlMedia, 'image'])
        end
        first = 0
        loop do ##loop for videos
            first = body.index('property="og:video" content="', first + 29)
            break if first.nil? == true

            urlMedia = body.slice(first + 29, first + 500)
            last = urlMedia.index('"')
            urlMedia = urlMedia.slice(0, last)

            urlMedia = urlMedia.gsub('\u0026', '&')

            toDownload.push([urlMedia, 'video'])
        end
        return toDownload.uniq
    end
end
