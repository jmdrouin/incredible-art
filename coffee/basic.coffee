console.log "this the basic demo"

window.demo = ->

    Star::black
        m: 10
        p: [250, 250]
        r: 10

    _.each _.range(10), ->
        s = 100
        Star::white
            p: [ rnd(500), rnd(500) ]
            m: s

    starLoop ->
