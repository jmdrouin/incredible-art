
console.log "star.coffee loaded"

CIRCONFERENCE = 2*Math.PI

class window.Star

    list: []

    dx: 0
    dy: 0
    x: 0
    y: 0
    r: 10

    setCanvas: (canvas) ->
        Star::canvas = canvas
        Star::context = canvas.getContext('2d')
        console.log "canvas is set to", canvas

    constructor: (params) ->
        console.log "star created:", @
        Star::list.push(@)
        _.extend @, params

    set: (sth) ->
        _.extend @, sth

    draw: ->
        @context.beginPath()
        @context.fillStyle = 'white'
        @context.arc(@x, @y, @r, 0, CIRCONFERENCE)
        @context.fill()

    update: (dt) ->
        @x += @dx * dt
        @y += @dy * dt
        @draw()

    updateAll: (dt) ->
        @context.clearRect 0, 0, @canvas.width, @canvas.height;
        _.each @list, (s) -> s.update dt

    drawAll: ->
        @context.clearRect(0, 0, @canvas.width, @canvas.height);
        _.each @list, (s)->s.draw()

window.star = factory Star

window.starLoop = (looper, dt=10) ->
    updateStars = (dt) ->
        looper()
        Star::updateAll dt
    setInterval (-> updateStars dt), dt
