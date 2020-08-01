module TT
    def TT.filename(url)
        first = url.index('tok.com/@') + 9
        last = url.index('/', first + 4)
        return url[first...last]
    end

    def TT.down(body)
        first = 0
        toDownload = []
        first = body.index('"video":{"urls":["', first + 18)

        urlMedia = body.slice(first + 18, first + 500)
        last = urlMedia.index('"')
        urlMedia = urlMedia.slice(0, last)

        urlMedia = urlMedia.gsub('\u0026', '&')

        toDownload.push([urlMedia, 'video'])
        return toDownload.uniq
    end
end