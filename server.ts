import * as restify from 'restify';
import * as cassandra from 'cassandra-driver';
import * as patch from './cassandra-patch';

var server = restify.createServer();

server.get('/',(req, res, next) => {
    console.log('get');
    res.send('Hello World');
    next();
});



server.listen(8080, () => {
    console.log('%s listening at %s %s', server.name, server.url, server.address().port);
  });


var PlainTextAuthProvider = cassandra.auth.PlainTextAuthProvider;
const client = new cassandra.Client({ contactPoints:['localhost:9042'], 
                                      authProvider: new PlainTextAuthProvider('cassandra', 'cassandra')});
  
client.connect()
    .then(function () {
      console.log('Connected to cluster with %d host(s): %j', client.hosts.length, client.hosts.keys());
      console.log('Keyspaces: %j', Object.keys(client.metadata.keyspaces));
      console.log('Shutting down');
      return client.shutdown();
    })
    .catch(function (err) {
      console.error('There was an error when connecting', err);
      return client.shutdown();
    });
