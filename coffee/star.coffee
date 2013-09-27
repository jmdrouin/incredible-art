
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
    debug3d: true
    displayRadius: null

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

    project: ([x, y, z]) ->
        z += @distance
        x = @zoom*x/z + @w/2 + @factors.movex
        y = @zoom*y/z + @h/2 + @factors.movey
        r = @r/z * @factors.size
        [x, y, r]


    invProject: ([x, y, r]) ->
        z = @r / (r - @distance) * @factors.size
        x = (x - @factors.movex - @w/2) * z / @zoom
        y = (y - @factors.movey - @h/2) * z / @zoom
        [x, y, z]

    draw: ->
        projected = @project @p
        if @p[2] + @distance > 0.000001
            [x, y, r] = projected
            r = @displayRadius or r
            if @useImage
                @context.drawImage(@starImage, x-2*r, y-2*r, 4*r, 4*r)
            else
                @context.beginPath()
                @context.arc x, y, r, 0, 2*Math.PI
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
        @context.globalAlpha = @factors.opacity
        @context.clearRect 0, 0, @canvas.width, @canvas.height

        if @debug3d
            line = ([px0, py0], [px1, py1]) =>
                @context.beginPath()
                @context.moveTo px0, py0
                @context.lineTo px1, py1
                @context.strokeStyle = '#f00'
                @context.lineWidth = 1
                @context.stroke()
            line @project([-200, -200, 200]), @project([-200, -200, -200])
            line @project([200, -200, 200]), @project([200, -200, -200])
            line @project([-200, 200, 200]), @project([-200, 200, -200])
            line @project([200, 200, 200]), @project([200, 200, -200])
            line @project([-200, 0, 0]), @project([200, 0, 0])
            line @project([0, -200, 0]), @project([0, 200, 0])

        # _.each @blackList, (s) -> s.draw()
        @context.fillStyle = "rgba(#{@whiteList[0].color},255)"
        _.each @whiteList, (s) -> s.update dt

    isOutOfCanvas: ->
        [x, y] = @p
        x < -Star::canvas.width or
            y < -Star::canvas.height or
            x >= Star::canvas.width or
            y >= Star::canvas.height

    pixelPosition: (W,H) ->
        [x, y] = @p
        i = x / 2 + Star::canvas.width / 2
        j = y / 2 + Star::canvas.height / 2
        [Math.floor(W*i/@w), Math.floor(H*j/@h)]

    setUpdateFunctions: (functions...) ->
        window.stepsVector = _.map _.range(functions.length), ->1
        @step = (dt) ->
            @intensity = null
            that = this
            _.each functions, (f,i)->
                f.call(that,dt,window.stepsVector[i])


window.star = factory Star

window.starLoop = (looper, dt=25) ->
    updateStars = (dt) ->
        looper()
        Star::updateAll dt
    setInterval (-> updateStars dt), dt
