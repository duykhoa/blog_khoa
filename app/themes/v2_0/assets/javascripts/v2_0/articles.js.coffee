ready = ->
  console.log 'haha'
  $('#share-social').share({
    networks: ['facebook','googleplus','twitter','linkedin'],
    theme: 'square'
  })

$(document).ready(ready)
