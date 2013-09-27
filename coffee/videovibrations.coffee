
window.demo = ->
    activateVideo (vid) ->
        Star::useImage = yes
        Star::video = vid
        Star::setUpdateFunctions(Star::applyIntensityFromVideo,
                                 Star::applyIntensityRadius,
                                 Star::applyRotation,
                                 Star::applyMovement)

        SPEED = 4
        _.each _.range(1000), ->
            p = [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
            thestar = Star::white
                    curve: rnd(0.005)
                    p: p
                    m: 20
                    r: 4
                    displayRadius: 4
                    maxg: 0.005
                    v: p.neg().normalize().times(SPEED)

        starLoop ->
            window.P = vid.update()