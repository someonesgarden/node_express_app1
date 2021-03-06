// Generated by CoffeeScript 1.10.0
(function() {
  var RSS, analyzeRSSbyCheerio, analyzeRSSbyXML2J, express, http, obj, request, result_str, router, xml, xml2js;

  express = require('express');

  http = require('http');

  router = express.Router();

  xml2js = require('xml2js');

  request = require('request');

  analyzeRSSbyXML2J = require('../funcs.coffee').analyzeRSSbyXML2J;

  analyzeRSSbyCheerio = require('../funcs.coffee').analyzeRSSbyCheerio;

  result_str = "";

  xml = "<fruits shop='AAA'><item price='140'>Banana</item><item price='200'>Apple</item></fruits>";

  obj = {
    item: {
      name: "Nananana",
      price: 150
    }
  };

  RSS = "http://rss.weather.yahoo.co.jp/rss/days/4410.xml";

  router.get('/', function(req, res) {
    var builder, xml2;
    xml2js.parseString(xml, function(err, result) {
      var i, item, items, j, len, results, shop;
      console.log("XML parse success:");
      console.log(JSON.stringify(result));
      result_str = JSON.stringify(result);
      shop = result.fruits.$.shop;
      console.log("shop=" + shop);
      items = result.fruits.item;
      results = [];
      for (i = j = 0, len = items.length; j < len; i = ++j) {
        item = items[i];
        console.log("-- name=" + item._);
        results.push(console.log("   price=" + item.$.price));
      }
      return results;
    });
    builder = new xml2js.Builder();
    xml2 = builder.buildObject(obj);
    console.log("converted xml:");
    console.log(xml2);
    request(RSS, function(err, res, body) {
      if (!err && res.statusCode === 200) {
        return analyzeRSSbyXML2J(body);
      }
    });
    analyzeRSSbyCheerio(RSS);
    return res.render('xmlpage', {
      title: 'xml parsing',
      body: result_str
    });
  });

  module.exports = router;

}).call(this);

//# sourceMappingURL=xmlpage.js.map
