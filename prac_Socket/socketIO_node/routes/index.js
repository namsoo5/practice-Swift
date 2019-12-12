var express = require('express');
var router = express.Router();

// /* GET home page. */
// router.get('/', function(req, res, next) {
//   res.render('index', { title: 'Express' });
// });

module.exports = router;

var app = require('express')();
var server = require('http').createServer(app);
// http server를 socket.io server로 upgrade한다
var io = require('socket.io')(server);

io.on('connection', (socket) => {
  console.log('a user connected');
  io.on('chat message', (msg) => {
    io.emit('chat message', msg);
  });
  io.on('disconnect', () => {
  console.log('user disconnected');
  });
});
io.listen(3001, () => {
  console.log('Connected at 3001');
});

/*
socket.on('event_name', function (data) {
  console.log('Message from Client: ' + data);
});

// 접속된 모든 클라이언트에게 메시지를 전송한다
io.emit('event1', msg);

// 메시지를 전송한 클라이언트에게만 메시지를 전송한다
socket.emit('event2', msg);

// 메시지를 전송한 클라이언트를 제외한 모든 클라이언트에게 메시지를 전송한다
socket.broadcast.emit('event3', msg);

// 특정 클라이언트에게만 메시지를 전송한다
io.to(id).emit('event_name', data);

// 클라이언트로부터의 메시지가 수신되면
socket.on('chat', function (data) {
  console.log('Message from %s: %s', socket.name, data.msg);

  var msg = {
    from: {
      name: socket.name,
      userid: socket.userid
    },
    msg: data.msg
  };

  // 메시지를 전송한 클라이언트를 제외한 모든 클라이언트에게 메시지를 전송한다
  socket.broadcast.emit('chat', msg);

      // force client disconnect from server
//   socket.on('forceDisconnect', function() {
//     socket.disconnect();
//   })

//   socket.on('disconnect', function() {
//     console.log('user disconnected: ' + socket.name);
//   });
// });

// server.listen(3000, function() {
//   console.log('Socket IO server listening on port 3000');
// });
*/