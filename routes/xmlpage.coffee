express   = require 'express'
http      = require 'http'
router    = express.Router()
xml2js    = require 'xml2js'

result_str = ""

xml = "<fruits shop='AAA'>"+
"<item price='140'>Banana</item>"+
"<item price='200'>Apple</item>"+
"</fruits>";

obj = {
  item:{name:"Nananana", price:150}
}

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
  console.log "converted xml:"
  console.log xml2

  res.render('xmlpage', {title:'xml parsing', body:result_str}))

module.exports = router