express       = require 'express'
http          = require 'http'
router        = express.Router()


#WEBデータの収集
url = "http://kujirahand.com/"
savepath = "test.html"

http = require 'http'
fs = require 'fs'

console.log url
console.log "unko"
outfile = fs.createWriteStream savepath

http.get(url, (res)->
  res.pipe(outfile)
  res.on('end', ()->
    outfile.close()
    console.log("ok")
  )
)

router.get('/', (req, res)-> res.render('index', {title:'TITLE22'}))


#=================================================================
module.exports = router