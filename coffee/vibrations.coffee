console.log "this the basic demo"

rotate = (p,angle) ->
    s = Math.sin(angle)
    c = Math.cos(angle)
    [c*p[0]-s*p[1], s*p[0]+c*p[1]]

window.demo = ->
    loadImage '/images/cells.png', (pixels) ->

        _.each _.range(2000), ->
            Star::white
                curve: rnd(-0.002,0.002)
                p: [ Star::canvas.width*rnd(1), Star::canvas.height*rnd(1)]
                m: 20
                r: 2
                maxg: 0.005
                v: [ 0.6*rnd(-1, 1), 0.6*rnd(-1, 1) ]
                step: (dt) ->

                    if @p[0]<0 or @p[1]<0 or @p[0]>=Star::canvas.width or @p[1]>=Star::canvas.height
                        intensity = 50
                    else
                        intensity = pixels[Math.floor(@p[0])][Math.floor(@p[1])] + 0.1

                    @v = rotate(@v,@curve * dt)
                    @p = @p.add(@v.times(dt*intensity))

        starLoop ->
