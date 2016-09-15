express   = require 'express'
http      = require 'http'
router    = express.Router()
download  = require('my/download.coffee').download
client    = require 'cheerio-httpcli'
URL       = require 'url'
request   = require 'request'
fs        = require 'fs'
path      = require 'path'

#savedir = __dirname + "/img"
savedir = "./public/img"
unless fs.existsSync(savedir)
  console.log savedir
  fs.mkdirSync(savedir)

# WEBデータの収集 -------------
url       = "http://kujirahand.com/"
savepath  = "public/test.html"
download(url, savepath, ()-> console.log("ok, kenji"))

# HTMLファイルから画像全てをダウンロード ----
url2      = "https://en.wikipedia.org/wiki/Dog"
param     = {}

client.fetch(url2,param,(err,$,res)->
  if err then console.log "Error:",err
  $("img").each(
    (idx)->
      #text = $(@).text(); href = $(@).attr('href')
      src = $(@).attr('src')
      if src?
        # 相対パスを絶対パスに変換 ----------------
        src2 = URL.resolve(url2, src)
        console.log (src2)
        fname = URL.parse(src2).pathname
        fname = savedir + "/" + fname.replace(/[^a-zA^Z0-9\.]+/g, '_')
        request(src2).pipe(fs.createWriteStream(fname))
  )
  #body = $.html()
)

# サイト丸ごとダウンロード ------------------------
LINK_LEVEL = 3
TARGET_URL="http://nodejs.jp/nodejs.org_ja/docs/v0.10/api/"
list = {}

checkSaveDir = (fname)->

  dir = path.dirname(fname)
  dirlist = dir.split("/")
  p = ""
  for d,i in dirlist
    p += d + "/"
    console.log "p>> " + p
    unless fs.existsSync(p) then fs.mkdirSync(p)

downloadRec = (url, level)->
  unless level >= LINK_LEVEL
    unless list[url]
      console.log "YES>> "+url
      list[url] = true
      us = TARGET_URL.split("/")
      us.pop()
      base = us.join("/")
      unless url.indexOf(base) < 0
        client.fetch(url, {},
          (err, $, res)->
            $("a").each(
              (idx)->
                href =$(@).attr('href')
                console.log "before replace>> "+ href+ "("+level+")"
                href = URL.resolve(url, href)
                href = href.replace(/\#.+$/, "")
                console.log "replaced>> "+ href + "("+level+")"
                downloadRec(href, level+1)
            )
            if url.substr(url.length-1,1) is '/' then url += "index.html"

            savepath = "/usr/src/app/site/"+url.split("/").splice(2).join("/")
            checkSaveDir(savepath)
            console.log savepath
            fs.writeFileSync(savepath, $.html())
        )

downloadRec(TARGET_URL, 0)
console.log "list"
console.log list



#=================================================================
router.get('/', (req, res)-> res.render('index', {title:'TITLE22'}))
module.exports = router