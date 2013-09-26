
window.demo = ->
    loadImage "/images/test.png", (pixels) ->
        console.log "Look at the image!"
        console.log pixels
