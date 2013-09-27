

window.activateVideo = (callback) ->
    video = $('#video')[0]
    context = $('#videodump')[0].getContext('2d')

    f = (stream) ->
        video.src = URL.createObjectURL(stream)
        video.play()
        videoObject =
            update: ->
                context.drawImage(video, 0, 0, video.width, video.height)
                imageData = context.getImageData(0,0,video.width,video.height)
                this.pixels = _.map _.range(video.width), (x) ->
                    _.map _.range(video.height), (y) ->
                        imageData.data[4*(x+y*video.height)]/255
        callback(videoObject)

    navigator.webkitGetUserMedia({video:true}, f)