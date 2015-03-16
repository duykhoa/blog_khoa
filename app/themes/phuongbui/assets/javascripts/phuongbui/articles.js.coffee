ready = ->
  $("#new_email_subscribe").on 'ajax:success', ->
    $(@).remove()
    $('.congrat').removeClass('hidden')

$(document).ready(ready)
