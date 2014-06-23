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
