module.exports = (io) => {
    const croom = io.of('/c');

    croom.on('connection', (clientSocket) => {
        console.log('*** c connected ***');

        clientSocket.on('disconnect', function () {
            clientSocket.disconnect();
            console.log('c disconnected');
        })
    })
}
