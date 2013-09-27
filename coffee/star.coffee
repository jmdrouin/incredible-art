
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
    distance: 400
    useImage: no
    displayRadius: null
    red: 0

    gravityDt: 0

    setCanvas: (canvas) ->
        Star::canvas = canvas
        Star::context = canvas.getContext('2d')
        Star::w = canvas.width
        Star::h = canvas.height

    constructor: (params...) ->
        @set params...

    white: ->
        @whiteList.push star {color: '255, 255, 255'}, arguments...
    black: ->
        @blackList.push star {color: '0, 0, 0', skip: true}, arguments...

    set: (sth...) ->
        for x in sth
            _.extend @, x

    draw: ->
        [x, y, z] = @p
        z += @distance
        if z > 0.00001
            cx = @zoom*x/z+@w/2 + (@factors.movex-0.5)*300
            cy = @zoom*y/z+@h/2 + (@factors.movey-0.5)*300
            r = (@displayRadius or @r/z) * @factors.size

            if @useImage
                @context.globalAlpha = @factors.opacity
                @context.drawImage(@starImage,cx-2*r,cy-2*r,4*r,4*r)
                @context.globalAlpha *= @red
                @context.drawImage(@redImage,cx-2*r,cy-2*r,4*r,4*r)
            else
                @context.beginPath()
                @context.arc cx, cy, r, 0, 2*Math.PI
                @context.fill()

    gravity: (other) ->
        sd = @p.sqDist other.p
        g = other.m / @m / sd
        g = Math.min g, @maxg
        @p.diff(other.p).normalize().times g

    update: (dt) ->
        @step?(dt)
        @draw()

    updateAll: (dt) ->
        @context.clearRect 0, 0, @canvas.width, @canvas.height;
        #_.each @blackList, (s) -> s.draw()
        @context.fillStyle = "rgba(#{@whiteList[0].color},255)"
        _.each @whiteList, (s) -> s.update dt


    isOutOfCanvas: ->
        @p[0] < -Star::canvas.width or
         @p[1] < -Star::canvas.height or
         @p[0] >= Star::canvas.width or
         @p[1] >= Star::canvas.height

    pixelPosition: (W,H) ->
        i = @p[0] / 2 + Star::canvas.width / 2
        j = @p[1] / 2 + Star::canvas.height / 2
        [Math.floor(W*i/@w), Math.floor(H*j/@h)]


    setUpdateFunctions: (functions...) ->
        @step = (dt) ->
            @intensity = null
            that = this
            _.each functions, (f, i) ->
                f.call(that, dt)


window.star = factory Star

window.starLoop = (looper, dt=40) ->
    updateStars = (dt) ->
        looper()
        Star::updateAll dt
    setInterval (-> updateStars dt), dt
