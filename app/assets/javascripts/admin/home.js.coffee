admin_ready = () ->
  $('.nano').nanoScroller()
  $('#article_content').summernote(
    height: 300,
    onImageUpload: (files, editor, welEditable) ->
      sendFile files[0], (data) ->
        debugger
        editor.insertImage(welEditable, data.path)
  )

  sendFile = (file, callback) ->
    data = new FormData()
    data.append("path", file)
    $.ajax {
      url: '/v2_admin/assets',
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      type: 'POST',
      success: (data) ->
        debugger
        callback(data)
    }
$(document).ready(admin_ready)
