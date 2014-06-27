# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  config = {
    ui: {
      flyout: 'middle right'
    }
    networks: {
      facebook: {
        app_id: '1505889032957471'
      },
      twitter: {
        enable: true
      }
      google_plus: {
        enable: true
      }
      pinterest: {
        enabled: false
      },
      email: {
        enabled: false
      }
    }
  }
  share = new Share(".share-button", config)
  share.open()

  subscribingValidate = ->
    $('form#new_email_subscribe').bind 'ajax:success', (xhr, data, status) ->
      if (data.success == false)
        $(this).parent().prepend("<div class='errors'>Email " + data.error_trace.email + '</div>')
      else
        $(this).siblings('div.errors').remove()
        $(this).parent().append("<div class= 'success'>Thank for subscribing</div>")
        $(this).toggle()
  subscribingValidate()
