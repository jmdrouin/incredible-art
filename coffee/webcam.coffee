

window.activateVideo = (callback) ->
    video = $('#video')[0]
    context = $('#videodump')[0].getContext('2d')

    f = (stream) ->
        video.src = URL.createObjectURL(stream)
        video.play()
        videoObject =
            width: video.width
            height: video.height
            update: ->
                context.drawImage(video, 0, 0, video.width, video.height)

                imageData = context.getImageData(0,0,video.height,video.width)

                this.pixels = _.map _.range(video.width), (x) ->
                    _.map _.range(video.height), (y) ->
                        k = 4*(x+y*video.height)
                        (imageData.data[k] + imageData.data[k+1] + imageData.data[k+2])/(3*255)

        callback(videoObject)

    navigator.webkitGetUserMedia({video:true}, f)