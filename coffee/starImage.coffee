
window.loadStarImage = (callback) ->
    image = new Image()

    image.onload = -> callback(image)

    image.src = '/images/star.png'