casper = require('casper').create()
casper.start()

casper.viewport(1024, 800) # 画面サイズを指定
casper.open("https://www.flickr.com") # flickrサイトをopen

casper.then(()-> @.fill("form[role='search']",{text:"ネコ"},true))
casper.then(()-> @.capture('flickr-cat.png', {top:0,left:0,width:1024,height:800}))

casper.run()
