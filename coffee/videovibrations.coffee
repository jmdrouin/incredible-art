
window.demo = ->
    activateVideo (vid) -> loadImage '/images/eye2.png', (pixels)->
        Star::pixels = pixels
        Star::useImage = yes
        Star::video = vid
        Star::videoIntensity = 0
        Star::imageIntensity = 1
        Star::setUpdateFunctions(Star::applyIntensityFromVideo,
                                 Star::applyIntensityFromImage,
                                 Star::applyIntensityRadius,
                                 Star::applyRotation,
                                 Star::applyMovement,
                                 Star::applyRespawn)

        SPEED = 6
        _.each _.range(1000), ->
            p = [ Star::canvas.width*rnd(-1,1), Star::canvas.height*rnd(-1,1), 0]
            thestar = Star::white
                    curve: rnd(0.005)
                    p: p
                    m: 20
                    r: 4
                    red: 0.2*Math.random()
                    displayRadius: 4
                    maxg: 0.005
                    v: p.neg().normalize().times(SPEED)

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


        connectMidi 'Launch Control', midiMap

        starLoop ->
            window.P = vid.update()
