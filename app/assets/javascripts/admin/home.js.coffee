admin_ready = () ->
  $('.nano').nanoScroller()
  $('#article_content').summernote(
    height: 300,
    onImageUpload: (files, editor, welEditable) ->
      sendFile files[0], (data) ->
        editor.insertImage(welEditable, data.path)
  )

  $('textarea#about_content').summernote(
    height: 300
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

  if $("#categories").length > 0
    Sortable.create(categories)

  #article Form
  $("form.article-new-or-edit input[type='submit']").on 'click', () ->
    $("#hidden-commit-field input#article_commit").val($(this).val())

  # Category JS
  $("#add-new-category-link").on 'click', () ->
    $("#add-new-category-form").toggleClass('hidden')
    false

  $("#add-new-category-form-tag").on 'submit', (e) ->
    text = $("#new-category-text-field").val()

    if text != ""
      $("#new-category-text-field").val("")
      $("ul#categories").append("<li contenteditable='true' data-original-name='" + text + "' class='list-group-item'>" +
        "<div class='row'>" +
        "<div class='col-xs-8'>" +
        text +
        "</div>" +
        "<div class='col-xs-1 col-xs-offset-3'>" +
        "<a href='#'>" +
        "<i class='fa fa-trash-o'/>" +
        "</a>" +
        "</div>" +
        "</div>" +
        "</li>
        ")
    false

  $(".remove-category-link").on 'click', () ->
    $(this).closest("li.list-group-item").remove()

  $(".add-new-category-cancel-button").on 'click', () ->
    $("input#new-category-text-field").val("")
    false

  $("#changing-category-list").on 'submit', () ->
    values = []
    $('ul#categories li').each (index, item) ->
      original_name = $(item).data('original-name')
      value = $(item).text().trim()
      values.push([original_name, value])

    data = { category_list: values }

    $.ajax {
      url: '/v2_admin/categories',
      data: data,
      type: 'POST',
      success: (data) ->
        console.log("cool")
    }
    false

$(document).ready(admin_ready)
