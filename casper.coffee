casper     = require('casper').create()

TARGET_URL = "http://kujirahand.com"
# これはcoffeeではなく
# casperjs casper.coffe　の形で実行する！
#=================================================================

casper.start(TARGET_URL, ()-> @.echo(casper.getTitle()))
casper.run()
