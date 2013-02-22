#= require lib/jquery.1.8.3.min.js
#= require lib/jquery-ui-1.9.2/js/jquery-ui-1.9.2.custom.min.js
#= require lib/jquery-autogrow-textarea.js
#= require lib/highlight.pack.js

jQuery ($) ->
  ui = {}

  #
  # query string into hidden input
  #
  domify = (query) ->
    [name, value] = query.split '='
    $('<input type="hidden" />')
      .attr('name', name)
      .attr('value', decodeURIComponent(value))

  #
  # save function
  #
  save = (method, path, query) ->
    localStorage.setItem('method', method)
    localStorage.setItem('path',   path)
    localStorage.setItem('query',  query)

  #
  # load function
  #
  load = ($method, $path, $query) ->
    [method, path, query] =
      ['method', 'path', 'query']
      .map (key) -> localStorage.getItem key

    $method.val(method) if method
    $path  .val(path)   if path && path.match(/^\//) && $path.val() == '/'
    $query .val(query)  if query

  #
  # init textarea auto grow
  #
  $('textarea').autoGrowTextarea()

  #
  # DOM capturing
  #
  $form    = $('#api-request-form')
  $method  = $('#method')
  $path    = $('#path')
  $query   = $('#query')
  $result  = $('#result')
  $time    = $('#response-time')
  $loading = $('#loading')
  prefix   = $form.attr 'action'

  #
  # load previous method, path, query
  #
  load $method, $path, $query

  #
  # on keydown of $query
  #
  $query.on 'keydown', (event) ->
    # enable submit on Ctrl + enter key
    if event.ctrlKey and event.keyCode is 13
      event.preventDefault()
      $form.trigger 'submit'

  #
  # on submit of $form
  #
  $form.on 'submit', (event) ->
    event.preventDefault()

    [method, path, query] =
      ['#method', '#path', '#query']
      .map (id) -> $(id).val()

    console.log method, path, query
    save method, path, query
    prepare $form, method, path, query

    display $.ajax prefix + path,
      type: method
      data: $form.serialize()

  prepare = ($form, method, path, query) ->
    $form
      .attr('method', method)
      .attr('action', prefix + path)

    $('input[type=hidden]', $form).remove()

    history.pushState({
      method: method,
      path: path,
      query: query
    }, path, '/' + method + path)

    query
      .replace(/\n/g, '&')
      .split('&')
      .filter((str) -> /\=/.test str)
      .map(domify)
      .forEach (input) ->
        $form.append input

  display = (ajax) ->
    start_time = Date.now()
    $loading.show()
    $time.text('')
    ajax.fail tryNativeFormSubmission
    ajax.always -> $loading.hide()
    ajax.done (res, status, xhr) ->
      response_time = Date.now() - start_time

      try
        response = JSON.parse(res)
        window.response = response
        json = JSON.stringify(response, null, '  ')
      catch e
        tryNativeFormSubmission()

      $time.text(response_time)
      $result.html(json)
      hljs.highlightBlock($result.get(0))

  tryNativeFormSubmission = ->
    $form[0].submit()

  $form.trigger 'submit'
