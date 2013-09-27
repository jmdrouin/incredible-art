console.log "this the basic demo"

rotate = (p,angle) ->
    s = Math.sin(angle)
    c = Math.cos(angle)
    [c*p[0]-s*p[1], s*p[0]+c*p[1], 0]

window.demo = ->
    loadImage '/images/cells.png', (pixels) ->

        _.each _.range(2000), ->
            Star::white
                curve: rnd(-0.002,0.002)
                p: [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
                m: 20
                r: 2
                maxg: 0.005
                v: [ 0.6*rnd(-1, 1), 0.6*rnd(-1, 1), 0 ]
                step: (dt) ->

                    if @p[0] < -Star::canvas.width or
                            @p[1] < -Star::canvas.height or
                            @p[0] >= Star::canvas.width or
                            @p[1] >= Star::canvas.height
                        intensity = 50
                    else
                        i = Math.floor(@p[0]/2+Star::canvas.width/2)
                        j = Math.floor(@p[1]/2+Star::canvas.height/2)
                        intensity = pixels[i][j] + 0.1

                    @v = rotate(@v,@curve * dt)
                    @p = @p.add(@v.times(dt*intensity))

        starLoop ->
