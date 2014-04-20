exports = this
exports.nico_player = null
class gon.Movies
  streaming: ->

  streamnico: ->
    setInterval ()->
      if exports.nico_player != null
        st = exports.nico_player.ext_getStatus()
        if st == "end"
          location.reload()
    , 1000

gon.movies_streamnico = ->
  @movies = new @Movies
  @movies.streamnico()

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

@onNicoPlayerReady = (id)->
  exports.nico_player = document.getElementById(id)