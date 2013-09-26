Star.draw = ->
    this.context.beginPath()
    this.context.fillStyle = 'white'
    this.context.arc(this.x, this.y, this.r, 0, CIRCONFERENCE)
    this.context.fill()
