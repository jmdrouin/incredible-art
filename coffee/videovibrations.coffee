Star::isOutOfCanvas = ->
    @p[0] < -Star::canvas.width or
     @p[1] < -Star::canvas.height or
     @p[0] >= Star::canvas.width or
     @p[1] >= Star::canvas.height

Star::pixelPosition = (W,H) ->
    i = @p[0] / 2 + Star::canvas.width / 2
    j = @p[1] / 2 + Star::canvas.height / 2
    [Math.floor(W*i/@w), Math.floor(H*j/@h)]

Star::applyRotation = (dt) ->
    s = Math.sin(dt * @curve)
    c = Math.cos(dt * @curve)
    @v = [c*@v[0]-s*@v[1], s*@v[0]+c*@v[1], 0]

Star::applyIntensityFromVideo = (dt) ->
    if @isOutOfCanvas()
        @intensity *= 50
    else
        px = @pixelPosition(@video.width, @video.height)
        @intensity *= 10 * @video.pixels[px[0]][px[1]]

Star::applyIntensityRadius = (dt) ->
    t = 0.5
    @r = t*@r + (1-t)*Math.min(10/@intensity,10)

Star::applyMovement = (dt) ->
    @p = @p.add(@v.times(@intensity))

window.demo = ->
    activateVideo (vid) ->
        Star::video = vid
        vibrateFromVideo = (dt) ->
            @intensity = 1
            @applyIntensityFromVideo(dt)
            @applyIntensityRadius(dt)
            @applyRotation(dt)
            @applyMovement(dt)

        SPEED = 2
        _.each _.range(2000), ->
            p = [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
            Star::white
                curve: rnd(0.005)
                p: p
                m: 20
                r: 4
                maxg: 0.005
                v: p.neg().normalize().times(SPEED)
                step: vibrateFromVideo

        starLoop ->
            window.P = vid.update()