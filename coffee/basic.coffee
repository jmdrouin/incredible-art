console.log "this the basic demo"

rnd = (low, high) ->
    if not high?
        high = low
        low = 0
    Math.random() * (high - low) + low

randomStar = ->
    x: rnd(500)
    y: rnd(500)
    r: rnd(30)
    dx: rnd(-0.5, 0.5)
    dy: rnd(-0.5, 0.5)

_.each _.range(10), ->
    params = randomStar()
    star params

window.demo = ->
    starLoop ->
