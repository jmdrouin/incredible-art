rotate = (p,angle) ->
    s = Math.sin(angle)
    c = Math.cos(angle)
    [c*p[0]-s*p[1], s*p[0]+c*p[1], 0]

window.demo = ->
    loadImage '/images/cells.png', (pixels) ->
        Star::useImage = no
        Star::pixels = pixels

        Star::setUpdateFunctions(Star::applyIntensityFromImage,
                                 Star::applyIntensityRadius,
                                 Star::applyRotation,
                                 Star::applyMovement)

        _.each _.range(3000), ->
            Star::white
                curve: rnd(-0.002,0.002)
                p: [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
                m: 20
                r: 2
                displayRadius: 4
                maxg: 0.005
                v: [ 2*rnd(-1, 1), 2*rnd(-1, 1), 0 ]

        starLoop ->
