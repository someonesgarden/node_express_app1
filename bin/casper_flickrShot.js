// Generated by CoffeeScript 1.10.0
(function() {
  var casper;

  casper = require('casper').create();

  casper.start();

  casper.viewport(1024, 800);

  casper.open("https://www.flickr.com");

  casper.then(function() {
    return this.fill("form[role='search']", {
      text: "ネコ"
    }, true);
  });

  casper.then(function() {
    return this.capture('flickr-cat.png', {
      top: 0,
      left: 0,
      width: 1024,
      height: 800
    });
  });

  casper.run();

}).call(this);

//# sourceMappingURL=casper_flickrShot.js.map
