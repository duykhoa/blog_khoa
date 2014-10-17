# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  activeSocialButton = ->
    setTimeout ( ->
      $('.social.middle.right').addClass('active')
      return
    ), 10

  config = {
    ui: {
      flyout: 'middle right'
    }
    networks: {
      facebook: {
        app_id: '1505889032957471',
        after: activeSocialButton
      },
      twitter: {
        enable: true,
        after: activeSocialButton
      }
      google_plus: {
        enable: true,
        after: activeSocialButton
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
  $('ul li.category-responsive').click ->
    $('.navigation-menu ul').toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
