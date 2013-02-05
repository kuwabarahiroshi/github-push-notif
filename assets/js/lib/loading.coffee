(->
  class Loading
    @img = $(document.createElement('img')).attr('src', '/icons/loading.gif')
    start: (position)->
      @img.append(document.body).position position
    stop: ()->

  app = window.app || (window.app = {})
  ui  = app.ui || (app.ui = {})
  app.ui.Loading = Loading
)()
