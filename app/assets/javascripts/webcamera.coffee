$ ->
  window.WebCamera = () ->
    error = (error) ->
      console.log error
    canvas = $('canvas#photo')[0]
    context = canvas.getContext('2d')
    video = $('video#video')[0]
    videoObj =
      'video': true

    if (navigator.getUserMedia)
      navigator.getUserMedia videoObj, (stream) ->
        video.src = stream
        video.play()
      , error
    else if (navigator.webkitGetUserMedia)
      navigator.webkitGetUserMedia videoObj, (stream) ->
        video.src = window.webkitURL.createObjectURL(stream)
        video.play()
      , error
    else if (navigator.mozGetUserMedia)
      navigator.mozGetUserMedia videoObj, (stream) ->
        video.src = window.URL.createObjectURL(stream)
        video.play()
      , error

    $shot = $('#shot')
    $shot.on 'click', (e) ->
      context.drawImage(video, 0, 0, 640, 480)
      image = new Image()
      image.src = canvas.toDataURL("image/png")