const app = require('express');
const router = app.Router();
const http = require('http').Server(app);
const io = require('socket.io')(http);

const roomList = require('../socket/roomList')
const testSocket = require('../socket/testRoom')
const bSocket = require('../socket/bRoom')
const cSocket = require('../socket/cRoom')
// const aroom = io.of('/a');
const room = io.of('/test');

router.get('/', function (req, res) {
  room.emit('test', {
    'Hello': 'World',
    'test': 'good'
  });
  res.send('<h1>AppCoda - SocketChat Server</h1>');
});

router.get('/getChatList/:name', (req, res) => {
  const name = req.params.name
  const list = roomList(name)
  res.send(list)
})


http.listen(9000, function () {
  console.log('Listening on *:9000');
});

testSocket(io)
bSocket(io)
cSocket(io)

/*
var express = require('express');
var router = express.Router();

const socketIO = require('socket.io');


module.exports = (server,app)=>{
  const io = socketIO(server);

  server.listen(9000, ()=>{
    console.log("listen,,,")
  })
  // const room = io.of('/room');
  // const chat = io.of('/chat');
  const room = io.of('/test');

  app.set('io',io);

  io.on('connection', (socket) => {
      const clientId = socket.id;
      socket.on('disconnect',()=>{})
  });

  room.on('connection',(socket)=>{
      let  roomListId;
      console.log("connect!!!")
      socket.on('init',(initdata)=>{
              roomListId = initdata._id;
              socket.join(roomListId)
      });
      socket.on('disconnect',()=>{
        console.log("disconnet!!")
          socket.leave(roomListId)
      });

  });

  chat.on('connection',(socket)=>{
      let currentRoomId;

      socket.on('init',(initdata)=>{
          currentRoomId = initdata.roomId;;
          socket.join(currentRoomId)
      });

      // socket.on('newChat',(data)=>{
      //     axios.post('http://localhost:9999/chat/newChat',data);
      // });

      socket.on('call',()=>{
          socket.to(chat).emit('call');
      });

      socket.on('disconnect',()=>{
          console.log(`채팅 네임스페이스 해제 ${currentRoomId}`);
          socket.leave(currentRoomId);
      })

  });


};
*/
/*
var app = require('express')();
var server = require('http').Server(app);
// http server를 socket.io server로 upgrade한다
var io = require('socket.io')(server)

console.log("testing...")

server.listen(9000, (data) => {
  console.log('listen!!')
})

io.on('connection', (socket) => {
  console.log('a user connected');
  socket.on('event1', (msg) => {
    console.log(msg);
    });

  socket.on('disconnect', function() {
    console.log('user disconnected: ' + socket.name);
  });
});


*/
/*
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

  // socket.on('disconnect', function() {
  //   console.log('user disconnected: ' + socket.name);
  // });
// });
// server.listen(3000, function() {
//   console.log('Socket IO server listening on port 3000');
// });
*/

module.exports = router;