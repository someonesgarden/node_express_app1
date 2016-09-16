express    = require 'express'
http       = require 'http'
router     = express.Router()


#=================================================================

router.get('/', (req, res)->

  res.render('casper', {title:'Casper / Phantom.js'}))
module.exports = router