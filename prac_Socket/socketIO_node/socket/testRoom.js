module.exports = (io) => {
    const room = io.of('/test');

    room.on('connection', (clientSocket) => {
        console.log('*** test connected ***');

        clientSocket.on('disconnect', function () {
            clientSocket.disconnect();
            console.log('test disconnected');
        })

        //echo
        //user = 0, other = 1
        clientSocket.on('test', (msg) => {
            console.log(msg)
            room.emit('test', {
                'type': 1,
                'message': msg
            })
        })

        clientSocket.on('event', (msg) => {
            console.log(msg)
            console.log(msg["message"])
            console.log('*************')
        })

        clientSocket.on('event1', (msg) => {
            console.log(msg)
            console.log(msg[0]["name"])
            console.log(msg[1]["email"])

            clientSocket.emit('test', { 'res': 'event1 response!' })
        })

        clientSocket.on('event2', (msg) => {
            console.log(msg)
            console.log(msg["name"])
            console.log(msg["email"])

            clientSocket.emit('test', { 'res': 'event2 response!' })
        })

        clientSocket.on('msg', (msg) => {
            console.log(msg)
            clientSocket.emit('test', { 'ack': 1 })
        })

    })
}