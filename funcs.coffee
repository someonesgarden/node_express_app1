analyzeRSSbyXML2J=(xml)->
  # Yahoo!Japan天気予報RSS解析用(rss.channel.itemになっていれば何でも）
  xml2js    = require 'xml2js'
  parseString = xml2js.parseString

  parseString(xml, (err,obj)->
    if err
      console.log(err)
    else
      console.log JSON.stringify(obj)
      items = obj.rss.channel[0].item
      for item,i in items
        console.log item.title[0]
  )

analyzeRSSbyCheerio = (RSS)->
  # cheerioを使ったRSSの解析
  client = require 'cheerio-httpcli'
  client.fetch(RSS, {}, (err, $, res)->
    if err
      console.log "error"
    else
      console.log "analyzeRSSByCHerio:"
      $("item > title").each((idx)-> title = $(@).text(); console.log title)


  )


#---------------------------------------------------------#
normalizePort=(val)->
  port = parseInt(val, 10);
  if isNaN(port) then return val
  if port >= 0 then return port
  return false

#---------------------------------------------------------#
onError=(error)->
  if error.syscall isnt 'listen' then throw error
  bind = if typeof port is 'string' then 'Pipe '+port else 'Port '+port
  switch error.code
    when 'EACCES'
      console.error(bind + ' requires elevated privileges')
      process.exit(1)

    when 'EADDRINUSE'
      console.error(bind + ' is already in use')
      process.exit(1)
    else throw error
#---------------------------------------------------------#
#セッションにreqから変数をセット
ss=(req)-> if req.session then req.session.user = req.body.username

rd=(res,forward)->  res.render 'login',{title:"Terrada ART FLATS",forward:forward}

op=(res,page,t,n,galid='gallery1',mode='edit',userjsonfound=false)-> res.render page, {title:t,username:n,galleryid:galid,gallerymode:mode,userjsonfound:userjsonfound}

#==========================================================#
module.exports = {
  'normalizePort':normalizePort
  'onError':onError
  'ss':ss
  'rd':rd
  'op':op
  'analyzeRSSbyXML2J':analyzeRSSbyXML2J
  'analyzeRSSbyCheerio':analyzeRSSbyCheerio
}