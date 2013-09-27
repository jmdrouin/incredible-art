console.log "this the basic demo"

window.demo = ->
    loadImage '/images/cells.png', (pixels) ->

        Star::useImage = yes

        NUMSTARS = 1000
        SPACING = 4
        _.each _.range(NUMSTARS), ->
            spacing = [Star::canvas.width/Math.sqrt(NUMSTARS)*SPACING
                       Star::canvas.height/Math.sqrt(NUMSTARS)*SPACING]

            initial = [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
            phase = rndv 2, Math.PI
            WHITE = 0.1
            SPEED = 0.001
            Star::white
                curve: rnd(-0.002,0.002)
                p: initial
                m: 20
                r: 100
                t: 0
                maxg: 0.005
                v: [ 0.6*rnd(-1, 1), 0.6*rnd(-1, 1), 0 ]
                step: (dt) ->

                    if @p[0] < -Star::canvas.width or
                            @p[1] < -Star::canvas.height or
                            @p[0] >= Star::canvas.width or
                            @p[1] >= Star::canvas.height
                        intensity = 0
                    else
                        i = Math.floor(@p[0]/2+Star::canvas.width/2)
                        j = Math.floor(@p[1]/2+Star::canvas.height/2)
                        intensity = pixels[i][j]
                    @t += dt*(intensity+WHITE)*SPEED
                    @p = [initial[0] + spacing[0]*Math.sin phase[0] + @t
                          initial[1] + spacing[1]*Math.sin phase[0] + @t
                          100 * Math.cos phase[0] + @t]

        starLoop ->
