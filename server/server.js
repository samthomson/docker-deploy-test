const http = require('http')


const server = http.createServer((req, res) => {
    res.end('19:08')
})

const PORT = 80

server.listen(PORT, () => {
    console.log('Listening on port', PORT)
})