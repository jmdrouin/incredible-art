

window.onLoad = ->
    layers = $('.layer').map (n,layer)->layer.getContext('2d')
    drawExamples(layers)


drawExamples = (layers) ->

    foreground = layer[1]

    # Lesson 1:
    forground.lineWidth = 10
    foreground.strokeStyle = "rgba(255,0,0,100)"
    foreground.lineCap = "round"
    foreground.lineJoin = "round"

    # Lesson 2: draw a curve
    foreground.beginPath()
    foreground.moveTo(50,50)
    foreground.bezierCurveTo(80,50,50,80,100,100)
    foreground.bezierCurveTo(150,120,120,150,50,150)
    foreground.stroke()
    foreground.closePath()