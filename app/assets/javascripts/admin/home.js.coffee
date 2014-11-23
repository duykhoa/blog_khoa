admin_ready = () ->
  $('.nano').nanoScroller()
  $('#article_content').summernote(
    height: 300
  )

$(document).ready(admin_ready)
