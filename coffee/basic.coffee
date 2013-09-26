console.log "this the basic demo"

rnd = (low, high) ->
    if not high
        high = low
        low = 0
    Math.random() * (high - low) + low

_.each _.range(10), ->
  star {x: rnd(500), y:rnd(500), r:rnd(30)}

window.demo = -> Star::drawAll()
