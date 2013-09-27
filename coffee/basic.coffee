console.log "this the basic demo"

window.demo = ->
    pic =
        [[0, 0, 0, 0, 0]
        ,[0, 0, 0, 0, 0]
        ,[1, 0, 0, 0, 1]
        ,[0, 0, 0, 0, 0]
        ,[0, 0, 0, 0, 0]]
    scale = 200
    for row, i in pic
        for pixel, j in row
            if pixel == 1
                Star::black
                    m: 5 + 20 * pixel
                    p: [j-2.5, i-2.5, 0].times scale
                    r: 500
                    color: '200,0,0'

    Star::setUpdateFunctions(Star::applyGravity, Star::applyMovement)

    _.each _.range(200), ->
        Star::white
            p:  [ rnd(-Star::canvas.width/2, Star::canvas.width/2)
                , rnd(-Star::canvas.height/2, Star::canvas.height/2)
                , rnd(-200, 300) ]
            m: 10
            r: 500
            maxg: 0.005
            v: _.flatten [rndv(2, -1/10, 1/10), 0]

    starLoop ->
