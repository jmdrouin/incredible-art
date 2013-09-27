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
    @r = (1-w/2)*@r + (w/2)*Math.min(0.1/@intensity,10)

Star::applyMovement = (dt, w) ->
    @p = @p.add(@v.times(@intensity*dt))
