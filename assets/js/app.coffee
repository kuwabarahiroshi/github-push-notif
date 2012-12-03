#= require lib/jquery.1.8.3.min.js
#= require lib/jquery-autogrow-textarea.js

jQuery ($) ->
  domify = (query) ->
    [name, value] = query.split '='
    $('<input type="hidden" />')
      .attr('name', name)
      .attr('value', decodeURIComponent(value))

  save = (method, path, query) ->
    localStorage.setItem('method', method)
    localStorage.setItem('path',   path)
    localStorage.setItem('query',  query)

  load = ($method, $path, $query) ->
    [method, path, query] =
      ['method', 'path', 'query']
      .map (key) -> localStorage.getItem key

    $method.val(method) if method
    $path  .val(path)   if path
    $query .val(query)  if query

  $('textarea').autoGrowTextarea()
  $form = $('#api-request-form')
  $method = $('#method')
  $path = $('#path')
  $query = $('#query')
  prefix = $form.attr 'action'

  load $method, $path, $query

  $query.on 'keydown', (event) ->
    if event.ctrlKey and event.keyCode is 13
      event.preventDefault()
      $form.trigger 'submit'

  $form.on 'submit', (event) ->
    [method, path, query] =
      ['#method', '#path', '#query']
      .map (id) -> $(id).val()

    save method, path, query

    $form
      .attr('method', method)
      .attr('action', prefix + path)

    $('input[type=hidden]', $form).remove()

    query
      .replace(/\n/g, '&')
      .split('&')
      .filter((str) -> /\=/.test str)
      .map(domify)
      .forEach (input) ->
        $form.append input
