client    = require 'cheerio-httpcli'
fs        = require 'fs'
path      = require 'path'
URL       = require 'url'

download = (url, savepath, callback)->
    http     = require 'http'
    fs       = require 'fs'
    outfile  = fs.createWriteStream savepath
    req = http.get(url, (res)->
        res.pipe(outfile)
        res.on('end', ()->
            outfile.close()
            callback()
        )
    )

checkSaveDir = (fname)->
    dir = path.dirname(fname); dirlist = dir.split("/")
    p = ""
    for d,i in dirlist
        p += d + "/"
        unless fs.existsSync(p) then fs.mkdirSync(p)

downloadRec = (list,TARGET_URL, LINK_LEVEL, url, level)->
    unless level >= LINK_LEVEL
        unless list[url]
            list[url] = true

            us = TARGET_URL.split("/"); us.pop()
            base = us.join("/")
            unless url.indexOf(base) < 0
                client.fetch(url, {}, (err, $, res)->
                        $("a").each(
                            (idx)->
                                href =$(@).attr('href')
                                href = URL.resolve(url, href)
                                href = href.replace(/\#.+$/, "")

                                downloadRec(list,TARGET_URL, LINK_LEVEL, href, level+1)
                        )
                        if url.substr(url.length-1,1) is '/' then url += "index.html"

                        savepath = "/usr/src/app/site/"+url.split("/").splice(2).join("/")
                        checkSaveDir(savepath)
                        fs.writeFileSync(savepath, $.html())
                        console.log list
                )


#==========================================================#
module.exports = {
    'download':download
    'downloadRec':downloadRec
}