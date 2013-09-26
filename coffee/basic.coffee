console.log "this the basic demo"

window.demo = ->
    pic =
        [[0, 1, 0, 1, 0]
        ,[1, 0, 1, 0, 1]
        ,[1, 0, 0, 0, 1]
        ,[0, 1, 0, 1, 0]
        ,[0, 0, 1, 0, 0]]

    for row, i in pic
        for pixel, j in row
            if pixel == 1
                Star::black
                    m: 5 + 20 * pixel
                    p: [j*100+250, i*100+50]
                    r: 5
                    color: 'black' # if pixel == 0 then '#300' else '#f00'

    _.each _.range(100), ->
        Star::white
            p: [ rnd(Star::canvas.width), rnd(Star::canvas.height) ]
            m: 5
            r: 3
            maxg: 0.005
            v: [ rnd(-1/10, 1/10), rnd(-1/10, 1/10) ]
            step: (dt) ->
                a = _.reduce @blackList, ((a, other) => a.diff @gravity(other)), [0, 0]
                @v = @v.add a.times dt
                @p = @p.add @v.times dt

    starLoop ->
