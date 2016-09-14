express       = require 'express'
http          = require 'http'
router        = express.Router()
download      = require('my/download.coffee').download

# WEBデータの収集 ------------

url      = "http://kujirahand.com/"
savepath = "public/test.html"


if typeof java is 'undefined'
  console.log "Java is not installed."
else
  console.log "java.version " + java.lang.System.getProperty("java.version")

aUrl = new java.new.URL url
conn = aUrl.openConnection()
ins  = conn.getInputStream()
file = new java.io.File savepath
out  = new java.io.FileOutputStream file
b    = null
while (b=ins.read()) isnt -1
    out.write(b)
out.close()
ins.close()


download(url, savepath, ()-> console.log("ok, kenji"))



router.get('/', (req, res)-> res.render('index', {title:'TITLE22'}))

#=================================================================
module.exports = router