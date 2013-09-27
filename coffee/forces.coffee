Star::factors =
    rotation:1
    radius:1
    videoIntensity:1
    imageIntensity:1
    gravity:1
    movement:1
    horizontalPull:1
    verticalPull:1
    size:1
    movex:0.5
    movey:0.5
    opacity:0.5

Star::applyRotation = (dt) ->
    s = Math.sin(dt * @factors.rotation * @curve)
    c = Math.cos(dt * @factors.rotation * @curve)
    @v = [c*@v[0]-s*@v[1], s*@v[0]+c*@v[1], 0]
    if Math.random() < dt/1000 then @curve = -@curve

Star::applyIntensityFromVideo = (dt) ->
    if @isOutOfCanvas()
        @intensity = @factors.videoIntensity * 50
    else
        px = @pixelPosition(@video.width, @video.height)
        @intensity = (@intensity||0) + 0.1 * @factors.videoIntensity * @video.pixels[px[0]][px[1]]

Star::applyIntensityRadius = (dt) ->
    t=@factors.radius/6
    @displayRadius = (1-t)*@displayRadius + t * Math.min(0.05/@intensity, 10)


Star::applyGravity = (dt) ->
    a = _.reduce @blackList, ((a, other) => a.diff @gravity(other)), [0, 0, 0]
    @v = @v.add a.times(dt*@factors.gravity)

Star::applyMovement = (dt) ->
    @p = @p.add(@v.times((@intensity||1)*dt*@factors.movement))

Star::applyIntensityFromImage = (dt) ->
    if @isOutOfCanvas()
        @intensity = @factors.imageIntensity * 50
    else
        px = @pixelPosition(@pixels.length, @pixels[0].length)
        @intensity = (@intensity||0) + 0.1 * @factors.imageIntensity * (@pixels[px[0]][px[1]] + 0.1)

Star::applyHorizontalPull = (dt) ->
    w = @factors.horizontalPull
    if @p[0] < 0 then @v[0]+=w*dt*0.001 else @v[0]-=w*dt*0.001

Star::applyVerticalPull = (dt, w) ->
    w = @factors.verticalPull
    if @p[1] < 0 then @v[1]+=w*dt*0.001 else @v[1]-=w*dt*0.001

Star::applyRespawn = (dt, w) ->
    if @p.dist([0, 0, 0]) > @w * 2
        p = [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
        @set
                    curve: rnd(0.005)
                    p: p
                    m: 20
                    r: 4
                    displayRadius: 0.0001
                    maxg: 0.005
                    v: p.neg().normalize().times(4)
