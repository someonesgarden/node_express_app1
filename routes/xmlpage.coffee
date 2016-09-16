express    = require 'express'
http       = require 'http'
router     = express.Router()
xml2js     = require 'xml2js'
request    = require 'request'
analyzeRSSbyXML2J = require('../funcs.coffee').analyzeRSSbyXML2J
analyzeRSSbyCheerio = require('../funcs.coffee').analyzeRSSbyCheerio

result_str = ""
xml = "<fruits shop='AAA'><item price='140'>Banana</item><item price='200'>Apple</item></fruits>";
obj = {item:{name:"Nananana", price:150}}
RSS = "http://rss.weather.yahoo.co.jp/rss/days/4410.xml"

#=================================================================

router.get('/', (req, res)->

  xml2js.parseString(xml, (err,result)->
      console.log "XML parse success:"
      console.log JSON.stringify(result)
      result_str = JSON.stringify(result)

      shop = result.fruits.$.shop
      console.log "shop=" + shop

      items = result.fruits.item;
      for item, i in items
        console.log "-- name="+ item._
        console.log "   price="+ item.$.price
  )

  builder = new xml2js.Builder()
  xml2 = builder.buildObject(obj)
  console.log "converted xml:"; console.log xml2

  # Yahoo!Japan 天気予報RSS (xml2jを使う方法）
  request(RSS, (err,res,body)->
    if !err and res.statusCode is 200 then analyzeRSSbyXML2J(body)
  )

  # Yahoo!Japan 天気予報RSS (cheerio-httpcliを使う方法）
  analyzeRSSbyCheerio(RSS)

  res.render('xmlpage', {title:'xml parsing', body:result_str}))

module.exports = router