
window.loadStarImage = (callback) ->
    image = new Image()

    image.onload = ->
        redImage = new Image()
        redImage.onload = ->
            Star::redImage = redImage
            callback(image)
        redImage.src = '/images/redstar.png'

    image.src = '/images/star.png'