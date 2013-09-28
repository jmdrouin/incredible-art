
window.demo = ->
    activateVideo (vid) -> loadImage '/images/eye2.png', (pixels)->
        Star::pixels = pixels
        Star::useImage = yes
        Star::video = vid
        Star::videoIntensity = 1
        Star::imageIntensity = 0
        Star::setUpdateFunctions(Star::applyIntensityFromVideo,
                                 Star::applyIntensityFromImage,
                                 Star::applyIntensityRadius,
                                 Star::applyRotation,
                                 Star::applyMovement,
                                 Star::applyRespawn)

        window.setVibrationMode = setVibrationMode = ->
            Star::setUpdateFunctions \
                Star::applyIntensityFromVideo,
                Star::applyIntensityFromImage,
                Star::applyIntensityRadius,
                Star::applyRotation,
                Star::applyMovement,
                Star::applyRespawn

        window.setGravityMode = setGravityMode = ->
            Star::setUpdateFunctions \
                Star::applyIntensityFromVideo,
                Star::applyIntensityFromImage,
                Star::applyIntensityRadius,
                Star::applyGravity,
                Star::applyMovement2,
                Star::applyRespawn2

        setVibrationMode()

        SPEED = 2

        Star::black
            m: 25
            p: [0,0,0]
            step: ->

        _.each _.range(1000), (i) ->
            p = [ Star::canvas.width*rnd(-1,1),
                  Star::canvas.height*rnd(-1,1), 0]

            thestar = Star::white
                    curve: rnd(0.01)
                    p: p
                    m: rnd(8,12)
                    r: 4
                    red: 0.3*Math.random()
                    displayRadius: 4
                    maxg: 0.001
                    gravityFilter: 3
                    gravityHack: i % 3
                    v: [rnd(-SPEED,SPEED), rnd(-SPEED,SPEED), 0]

        midiMap = {}
        V = _.map [0..15], ->1

        for i in [0..15]
            midiMap[[176, 21+i]] = do (i=i) -> (v) ->
                    V[i] = v/128
                    updateFactors()

        updateFactors = ->
            console.log V
            Star::factors.opacity = V[0]+V[1]
            Star::factors.videoIntensity = V[2]
            Star::factors.movement = V[3]+0.5
            Star::factors.size = V[2]/2+V[4]/2
            Star::factors.movex = 100*(V[5]-V[6]+V[7])-50
            Star::factors.movex = 100*(V[6]+V[7]-V[8])-50

        midiMap2 = {}
        midiMap2[[176, 21]] = (v) ->
            if v > 64
                console.log "vibration mode!!!"
                setVibrationMode()
            else
                console.log "gravity mode!!!"
                setGravityMode()

        connectMidi 'Launch Control', midiMap2

        starLoop ->
            window.P = vid.update()
