
console.log "hello from image"

window.loadImage = (url, callback) ->

    canvas = $("#secret")[0]
    context = canvas.getContext('2d')
    imageObj = new Image()

    imageObj.onload = ->
        context.drawImage(this, 0, 0)
        imageData = context.getImageData(0,0,canvas.height,canvas.width)
        pixels = _.map _.range(canvas.width), (x) ->
            _.map _.range(canvas.height), (y) ->
                imageData.data[4*(x+y*canvas.height)]/255
        callback(pixels)

    imageObj.src = url