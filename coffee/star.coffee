
console.log "star.coffee loaded"

CIRCONFERENCE = 2*Math.PI

Star = window.Star =
  list:[]

  setCanvas: (canvas) ->
    Star.canvas = canvas
    Star.context = canvas.getContext('2d')
    console.log "canvas is set to", canvas

  create: (params) ->
    that = _.extend Object.create(Star), params
    console.log "star created:", that
    Star.list.push(that)
    return that

  draw: ->
    this.context.beginPath()
    this.context.fillStyle = 'white'
    this.context.arc(this.x, this.y, this.r, 0, CIRCONFERENCE)
    this.context.fill()

  drawAll: ->
    this.context.clearRect(0, 0, Star.canvas.width, Star.canvas.height);
    _.each this.list, (s)->s.draw()