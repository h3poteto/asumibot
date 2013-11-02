$ ->
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


