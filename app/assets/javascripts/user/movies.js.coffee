class gon.Movies
  streaming: ->
gon.movies_streaming = ->
  @movies = new @Movies
  @movies.streaming()

@onYouTubeIframeAPIReady = ()->
  movie = gon.youtube[Math.floor(Math.random()*(gon.youtube).length)]
  $(".title").html(movie.title)
  player = new YT.Player('player',{
    height: '390',
    width: '640',
    videoId: movie.id,
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange,
      onError: onPlayerError
    }
  })

@playNext = (player)->
  player.clearVideo()
  movie = gon.youtube[Math.floor(Math.random()*(gon.youtube).length)]
  $(".title").html(movie.title)
  player.loadVideoById(movie.id,0,"large")
  player.playVideo()

@onPlayerReady = (event)->
  event.target.playVideo()

@onPlayerStateChange = (event)->
  if event.data == YT.PlayerState.ENDED
    playNext(event.target)

@onPlayerError = (event)->
  playNext(event.target)
    