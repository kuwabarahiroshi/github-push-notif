class Page
  constructor: (@req, @res)->
    @route = ''
    @id = ''
    @class = []
    @title = 'default title'
    @description = 'default description'
    @keywords = ['key words', 'other words']

  fix: ->
    @route = @req.route
    @segments = @route.id.split('.')
    @id = @segments.join('-')
    @classify @segments

  classify: (segments)->
    hierarchy = segments.slice()
    while hierarchy.length
      @class.unshift hierarchy.join('-')
      hierarchy.pop()

# express middleware
#
identify = ->
  (req, res, next)->
    req.app.locals.page = new Page(req, res)
    next()

module.exports =
  identify: identify
