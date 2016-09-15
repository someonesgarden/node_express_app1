
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
}