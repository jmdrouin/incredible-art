
window.assert = (fn) ->
    if not fn()
        console.log "SHIT:", fn.toString()
    else
        console.log "COOL:", fn.toString()

console.log "I'm util"

Array::sum = ->
    _.reduce @, (a, b) -> a + b

assert -> [1, 2, 3].sum() == 6

Array::add = (others...) ->
    _.map _.zip(@, others...), (x) -> x.sum()

assert -> _.isEqual [1, 2, 3].add([2, 3, 4]), [3, 5, 7]

Array::diff = (other) ->
    @add other.neg()

Array::times = (factor) ->
    _.map @, (x) -> x * factor

assert -> _.isEqual [1, 2, 3].times(2), [2, 4, 6]

Array::mult = (others...) ->
    _.map _.zip(@, others...), (x) -> _.reduce x, ((a, b) -> a * b)

assert -> _.isEqual [1, 2, 3].mult([1, 2, 3]), [1, 4, 9]

Array::dot = (others...) ->
    _.reduce @mult(others...), (a, b) -> a + b

assert -> _.isEqual [1, 2, 3].dot([2, 3, 4]), 20

Array::neg = ->
    _.map @, (x) -> x * -1

Array::inv = ->
    _.map @, (x) -> 1 / x

assert -> _.isEqual [1, 2, 3].neg(), [-1, -2, -3]

Array::sqDist = (other) ->
    diff = @add other.neg()
    diff.mult(diff).sum()

assert -> [1, 2].sqDist([2, 4]) == 5

Array::dist = (other) ->
    Math.sqrt @sqDist other

Array::normalize = ->
    zero = _.map([0 .. @length-1 ], -> 0)
    @times(1 / @dist(zero))

assert -> _.isEqual [3, 4].normalize(), [0.6, 0.8]

console.log "NORM", [3, 4].normalize()

window.factory = (Klass) -> -> new Klass arguments...

window.rnd = (low, high) ->
    if not high?
        high = low
        low = 0
    Math.random() * (high - low) + low

window.rndv = (dim, low, high) ->
    for x in [0..dim-1]
        rnd low, high
