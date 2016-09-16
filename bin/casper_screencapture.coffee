## Flickrの検索結果画面をキャプチャー画像にするコード

#CasperJSオブジェクトを作成
casper = require('casper').create()
casper.start() #開始

#ページを開き、スクリーンショットを撮影
casper.open('http://google.co.jp')
casper.then(()->casper.capture("screenshot.png"))
casper.run() #実行


