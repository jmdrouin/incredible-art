PORT = 5000

express = require 'express'
app = express()
coffee = require 'coffee-script'
fs = require 'fs'

app.get '/:script.coffee', (req, res) ->
  console.log req.params.script
  res.header 'Content-Type', 'application/x-javascript'
  cs = fs.readFileSync "#{__dirname}/coffee/#{req.params.script}.coffee", "ascii"
  res.send coffee.compile(cs)

app.use "/dependencies", express.static(__dirname + '/dependencies')

app.get '/', (req, res) -> res.render('index.jade')

app.listen PORT, -> console.log("Listening on port " + PORT)