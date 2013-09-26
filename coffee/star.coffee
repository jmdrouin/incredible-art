
console.log "star.coffee loaded"

CIRCONFERENCE = 2*Math.PI

class window.Star

    list: []

    setCanvas: (canvas) ->
        Star::canvas = canvas
        Star::context = canvas.getContext('2d')
        console.log "canvas is set to", canvas

    constructor: (params) ->
        console.log "star created:", @
        Star::list.push(@)
        _.extend @, params

    draw: ->
        @context.beginPath()
        @context.fillStyle = 'white'
        @context.arc(@x, @y, @r, 0, CIRCONFERENCE)
        @context.fill()

    drawAll: ->
        @context.clearRect(0, 0, @canvas.width, @canvas.height);
        _.each @list, (s)->s.draw()

window.star = factory Star
