const http = require('http')


const server = http.createServer((req, res) => {
    res.end('served..')
})

const PORT = 80

server.listen(PORT, () => {
    console.log('Listening on port', PORT)
})