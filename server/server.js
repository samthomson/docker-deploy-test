const http = require('http')


const server = http.createServer((req, res) => {
    res.end('15:42')
})

const PORT = 80

server.listen(PORT, () => {
    console.log('Listening on port', PORT)
})