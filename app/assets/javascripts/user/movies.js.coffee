class gon.Movies
  streaming: ->

  streamnico: ->
    document._write = document.write
    document.write = (msg) ->
      $("#nico_player").html(msg)
      document.write = document._write

    id = gon.nicovideo.id
    src = "http://ext.nicovideo.jp/thumb_watch/" + id
    dst = $("<script>")
    dst.attr("type", "text/javascript")
    dst.attr("src", src)

    $("#player").append(dst)

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
  exports.niconico_player = document.getElementById(id)

@onNicoPlayerStatus = (id, status)->
  if status == "end"
    console.log(status)
    location.reload()
