// Generated by CoffeeScript 1.10.0
(function() {
  var app, debug, http, io, onError, onListening, path, server;

  path = require('path');

  debug = require('debug')('Docker_Node_Express');

  http = require('http');

  app = require('../app.coffee');

  io = require(path.resolve(path.join('./socketio', 'server.coffee')));

  app.set('port', parseInt(process.env.PORT, 10) || 8080);

  server = http.createServer(app);

  onError = require('../funcs.coffee').onError;

  onListening = function() {
    return debug('Listening on port ' + server.address().port);
  };

  io(server);

  server.listen(app.get('port'));

  server.on('error', onError);

  server.on('listening', onListening);

}).call(this);

//# sourceMappingURL=www.js.map
