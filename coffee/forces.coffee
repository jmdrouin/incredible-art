Star::applyRotation = (dt, w) ->
    s = Math.sin(dt * w * @curve)
    c = Math.cos(dt * w * @curve)
    @v = [c*@v[0]-s*@v[1], s*@v[0]+c*@v[1], 0]
    if Math.random() < dt/1000 then @curve = -@curve

Star::applyIntensityFromVideo = (dt, w) ->
    if @isOutOfCanvas()
        @intensity = w * 50
    else
        px = @pixelPosition(@video.width, @video.height)
        @intensity = (@intensity||0) + 0.1 * w * @video.pixels[px[0]][px[1]]

Star::applyIntensityRadius = (dt, w) ->
    t=w/6
    @displayRadius = (1-t)*@displayRadius + t*Math.min(0.1/@intensity,10)

Star::applyGravity = (dt, w) ->
    a = _.reduce @blackList, ((a, other) => a.diff @gravity(other)), [0, 0, 0]
    @v = @v.add a.times(dt*w)

Star::applyMovement = (dt, w) ->
    @p = @p.add(@v.times((@intensity||1)*dt*w))

Star::applyIntensityFromImage = (dt, w) ->
    if @isOutOfCanvas()
        @intensity = w * 50
    else
        px = @pixelPosition(@pixels.length, @pixels[0].length)
        @intensity = (@intensity||0) + 0.1 * w * (@pixels[px[0]][px[1]] + 0.1)
