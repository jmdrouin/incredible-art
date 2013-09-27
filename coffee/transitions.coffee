window.demo = ->
    loadImage '/images/cells.png', (pixels) ->
        activateVideo (vid) ->
            Star::useImage = no
            Star::pixels = pixels
            Star::video = vid

            Star::setUpdateFunctions(Star::applyIntensityFromImage,
                                     Star::applyIntensityFromVideo,
                                     Star::applyIntensityRadius,
                                     Star::applyRotation,
                                     Star::applyMovement)

            _.each _.range(1000), ->
                Star::white
                    curve: rnd(-0.002,0.002)
                    p: [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
                    m: 20
                    r: 2
                    displayRadius: 4
                    maxg: 0.005
                    v: [ 2*rnd(-1, 1), 2*rnd(-1, 1), 0 ]

            window.stepsVector[0]=0
            window.transition = ->
                window.stepsVector[0] = 1 - window.stepsVector[0]
                window.stepsVector[1] = 1 - window.stepsVector[1]

            starLoop ->
                vid.update()