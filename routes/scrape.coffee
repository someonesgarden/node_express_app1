express   = require 'express'
http      = require 'http'
router    = express.Router()
download  = require('../download.coffee').download
downloadRec  = require('../download.coffee').downloadRec
client    = require 'cheerio-httpcli'
URL       = require 'url'
request   = require 'request'
fs        = require 'fs'
path      = require 'path'


#=================================================================

router.get('/', (req, res)->

  # 1. WEBデータの収集 -------------
  url       = "http://kujirahand.com/"
  savepath  = "public/test.html"
  download(url, savepath, ()-> console.log("ok, kenji"))

  # 2. HTMLファイルから画像全てをダウンロード ----
  url2      = "https://en.wikipedia.org/wiki/Dog"
  param     = {}

  #savedir = __dirname + "/img"
  savedir = "./public/img"
  unless fs.existsSync(savedir)
    console.log savedir
    fs.mkdirSync(savedir)

  client.fetch(url2,param,(err,$,res)->
    if err then console.log "Error:",err
    $("img").each(
      (idx)->
  #text = $(@).text(); href = $(@).attr('href')
        src = $(@).attr('src')
        if src?
  # 相対パスを絶対パスに変換 ----------------
          src2 = URL.resolve(url2, src)
          #console.log (src2)
          fname = URL.parse(src2).pathname
          fname = savedir + "/" + fname.replace(/[^a-zA^Z0-9\.]+/g, '_')
          request(src2).pipe(fs.createWriteStream(fname))
    )
  #body = $.html()
  )

  # 3. サイト丸ごとダウンロード ------------------------
  LINK_LEVEL = 3
  TARGET_URL="http://nodejs.jp/nodejs.org_ja/docs/v0.10/api/"
  list = {}
  downloadRec(list,TARGET_URL, LINK_LEVEL, TARGET_URL, 0)
  console.log "list>>>"
  console.log list
  res.render('scrape', {title:'SCRAPE', body:JSON.stringify(list)}))

module.exports = router