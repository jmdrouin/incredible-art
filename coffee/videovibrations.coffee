Star::isOutOfCanvas = ->
    @p[0] < -Star::canvas.width or
     @p[1] < -Star::canvas.height or
     @p[0] >= Star::canvas.width or
     @p[1] >= Star::canvas.height

Star::pixelPosition = (W,H) ->
    i = @p[0] / 2 + Star::canvas.width / 2
    j = @p[1] / 2 + Star::canvas.height / 2
    [Math.floor(W*i/@w), Math.floor(H*j/@h)]

Star::applyRotation = (dt, w) ->
    s = Math.sin(dt * w * @curve)
    c = Math.cos(dt * w * @curve)
    @v = [c*@v[0]-s*@v[1], s*@v[0]+c*@v[1], 0]

Star::applyIntensityFromVideo = (dt, w) ->
    if @isOutOfCanvas()
        @intensity *= w * 50
    else
        px = @pixelPosition(@video.width, @video.height)
        @intensity *= 0.1 * w * @video.pixels[px[0]][px[1]]

Star::applyIntensityRadius = (dt, w) ->
    @r = (1-w)*@r + w*Math.min(0.1/@intensity,10)

Star::applyMovement = (dt, w) ->
    @p = @p.add(@v.times(@intensity*dt))

Star::setUpdateFunctions = (functions...) ->
    window.stepsVector = _.map _.range(functions.length), ->1
    @step = (dt) ->
        @intensity = 1
        that = this
        _.each functions, (f,i)->
            f.call(that,dt,window.stepsVector[i])

window.demo = ->
    activateVideo (vid) ->
        Star::video = vid

        Star::setUpdateFunctions(Star::applyIntensityFromVideo,
                                 Star::applyIntensityRadius,
                                 Star::applyRotation,
                                 Star::applyMovement)

        SPEED = 2
        _.each _.range(1000), ->
            p = [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
            thestar = Star::white
                    curve: rnd(0.005)
                    p: p
                    m: 20
                    r: 4
                    maxg: 0.005
                    v: p.neg().normalize().times(SPEED)

        starLoop ->
            window.P = vid.update()