class gon.AdminsSerifs
  index: ->
    $('.more').click ->
      $('.none').each (i, e)->
        if i < 25
          $(@).removeClass("none")

      value = 0
      if $(@).val() - 25 > 0
        value = $(@).val() - 25

      $(@).val(value)
      $(@).text("続きを読む（" + value + "）")
      if value == 0
        $(@).hide()

gon.admins_serifs_index = ->
  @admins_serifs = new @AdminsSerifs
  @admins_serifs.index()


