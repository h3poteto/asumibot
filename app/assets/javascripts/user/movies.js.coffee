class gon.Movies
  streaming: ->
gon.movies_streaming = ->
  @movies = new @Movies
  @movies.streaming()

@onYouTubeIframeAPIReady = ()->
  player = new YT.Player('player',{
    height: '390',
    width: '640',
    videoId: gon.youtube[Math.floor(Math.random()*(gon.youtube).length)],
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange,
      onError: onPlayerError
    }
  })

@playNext = (player)->
  player.clearVideo()
  player.loadVideoById(gon.youtube[Math.floor(Math.random()*(gon.youtube).length)],0,"large")
  player.playVideo()

@onPlayerReady = (event)->
  event.target.playVideo()

@onPlayerStateChange = (event)->
  if event.data == YT.PlayerState.ENDED
    playNext(event.target)

@onPlayerError = (event)->
  playNext(event.target)
    