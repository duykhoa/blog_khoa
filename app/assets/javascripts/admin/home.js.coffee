admin_ready = () ->
  $('.nano').nanoScroller()
  $('#article_content').summernote(
    height: 300,
    onImageUpload: (files, editor, welEditable) ->
      sendFile files[0], (data) ->
        editor.insertImage(welEditable, data.path)
  )

  $(document).ajaxStart () ->
     NProgress.start()

  $(document).ajaxComplete () ->
     NProgress.done()

  sendFile = (file, callback) ->
    # TODO check file is less than 1MB

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
        callback(data)
    }
$(document).ready(admin_ready)
