module.exports = (io) => {
    const broom = io.of('/b');
    broom.on('connection', (clientSocket) => {
        console.log('*** b connected ***');

        clientSocket.on('disconnect', function () {
            clientSocket.disconnect();
            console.log('b disconnected');
        })
    })
}