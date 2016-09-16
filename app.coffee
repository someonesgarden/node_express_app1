'use strict'
console.log "di2>>>" + __dirname
#MIDDLEWARE =====================
express       = require 'express'
session       = require 'express-session'
favicon       = require 'serve-favicon'
path          = require 'path'
fs            = require 'fs'
logger        = require 'morgan'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
multer        = require 'multer'

# ===============
index         = require './routes/index.coffee'
scrape        = require './routes/scrape.coffee'
xmlpage       = require './routes/xmlpage.coffee'

# view engine setup ====================================
app = express()
app.set('views',path.join(__dirname, 'views'))
app.set('view engine','jade')

# USE middleware  =======================================
app.use favicon(__dirname + '/public/favicon.ico')
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })
app.use cookieParser()
app.use session {
  secret: 'session_secret_key'
  resave: false
  saveUninitialized: true
}

app.use express.static(path.join(__dirname, 'public'))
app.use('/',        index)
app.use('/index',   index)
app.use('/scrape',  scrape)
app.use('/xml',     xmlpage)

# ERROR HANDLING =======================================================
app.use (req, res, next)->
  err = new Error('Not Found')
  err.status = 404
  next(err)

if app.get('env') is 'development'
  app.use (err, req, res, next)->
    res.status(err.status || 500)
    res.render('error', {message: err.message, error: err})

app.use (err, req, res, next)->
  res.status(err.status || 500)
  res.render('error', {message: err.message, error:{}})


#=================================================================
module.exports = app