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

    if file.size > 2 * 1024 * 1024
      $("#article_content").notify(
        "Limit image size 2MB",
          position: "top center"
          className: "warn"
        ,
      )
      return false

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

  Sortable.create(categories)

$(document).ready(admin_ready)
