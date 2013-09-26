
console.log "star.coffee loaded"

CIRCONFERENCE = 2*Math.PI

class window.Star

    whiteList: []
    blackList: []

    p: [0, 0]
    v: [0, 0]
    r: 10
    m: 5
    maxg: 10
    maxv: [10, 10]
    color: 'white'

    setCanvas: (canvas) ->
        Star::canvas = canvas
        Star::context = canvas.getContext('2d')
        console.log "canvas is set to", canvas

    constructor: (params...) ->
        console.log "star created:", @
        @set params...

    white: ->
        @whiteList.push star {color: 'white'}, arguments...
    black: ->
        @blackList.push star {color: 'black', skip: true}, arguments...

    set: (sth...) ->
        for x in sth
            _.extend @, x

    draw: ->
        @context.beginPath()
        @context.fillStyle = @color
        [x, y] = @p
        @context.arc x, y, @r, 0, CIRCONFERENCE
        @context.fill()

    gravity: (other) ->
        sd = @p.sqDist other.p
        g = other.m / @m / sd
        g = Math.min g, @maxg
        r = @p.diff(other.p).normalize().times g
        r

    update: (dt) ->
        if not @skip
            a = _.reduce @blackList, ((a, other) => a.diff @gravity(other)), [0, 0]
            @v = @v.add a.times dt
            @p = @p.add @v.times dt
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
