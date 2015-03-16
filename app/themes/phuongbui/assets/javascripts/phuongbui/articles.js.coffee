ready = ->
  $("#new_email_subscribe").on 'ajax:success', (event, data, status) ->
    if data.success
      $(@).remove()
      $('.congrat').removeClass('hidden')

$(document).ready(ready)
