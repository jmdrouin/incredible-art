
console.log "star.coffee loaded"

class window.Star

    whiteList: []
    blackList: []

    p: [0, 0, 0]
    v: [0, 0, 0]
    r: 10
    m: 5
    maxg: 10
    color: 'white'
    zoom: 300
    distance: 500

    setCanvas: (canvas) ->
        Star::canvas = canvas
        Star::context = canvas.getContext('2d')
        console.log "canvas is set to", canvas

    constructor: (params...) ->
        console.log "star created:", @
        @set params...

    white: ->
        @whiteList.push star {color: '255, 255, 255'}, arguments...
    black: ->
        @blackList.push star {color: '0, 0, 0', skip: true}, arguments...

    set: (sth...) ->
        for x in sth
            _.extend @, x

    draw: ->
        @context.beginPath()
        [x, y, z] = @p
        z += @distance
        if z > 0.00001
            w = @canvas.width
            h = @canvas.height
            r = @r/z
            alpha = 255
            @context.fillStyle = "rgba(#{@color},#{alpha})"
            r = Math.max(r, 1)
            @context.arc @zoom*x/z+w/2, @zoom*y/z+h/2, r, 0, 2*Math.PI
            @context.fill()

    gravity: (other) ->
        sd = @p.sqDist other.p
        g = other.m / @m / sd
        g = Math.min g, @maxg
        r = @p.diff(other.p).normalize().times g
        r

    update: (dt) ->
        @step?(dt)
        @draw()

    updateAll: (dt) ->
        @context.clearRect 0, 0, @canvas.width, @canvas.height;
        _.each @blackList, (s) -> s.update dt
        _.each @whiteList, (s) -> s.update dt

window.star = factory Star

window.starLoop = (looper, dt=10) ->
    updateStars = (dt) ->
        looper()
        Star::updateAll dt
    setInterval (-> updateStars dt), dt
