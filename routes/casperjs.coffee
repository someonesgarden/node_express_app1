express    = require 'express'
http       = require 'http'
router     = express.Router()
casper     = require('casper').create()

TARGET_URL = "http://kujirahand.com"


#=================================================================

router.get('/', (req, res)->

  casper.start(TARGET_URL, ()-> @.echo(casper.getTitle()))
  casper.run()

  res.render('casper', {title:'Casper / Phantom.js'}))

module.exports = router