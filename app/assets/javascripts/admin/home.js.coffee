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

  if $("#categories")
    Sortable.create(categories)

  # Category JS
  $("#add-new-category-link").on 'click', () ->
    $("#add-new-category-form").toggleClass('hidden')
    false

  $("#add-new-category-form-tag").on 'submit', (e) ->
    text = $("#new-category-text-field").val()

    if text != ""
      $("#new-category-text-field").val("")
      $("ul#categories").append("<li contenteditable='true' data-origin-name='" + text + "' class='list-group-item'>" +
        "<div class='col-xs-8'>" +
        text +
        "</div>" +
        "<div class='col-xs-1 col-xs-offset-3'>" +
        "<a href='#'>" +
        "<i class='fa fa-trash-o'/>" +
        "</a>" +
        "</div>" +
        "</li>
        ")
    false

$(document).ready(admin_ready)
