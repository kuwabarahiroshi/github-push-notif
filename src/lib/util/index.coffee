# Utility library

# Freeze object recursively.
#
# @param [Object] o Object to be frozen.
# @return [Object] o Returns given object itself.
deepFreeze = (o) ->
  # freeze given object itself.
  Object.freeze o

  #recursively freeze object properties.
  for own key, val of o
    continue unless typeof val is 'object'
    continue if Object.isFrozen val
    deepFreeze val

  return o

# merge objects
#
# @param [Object] extendee
# @param [Object] extenders
# @return [Object] extendee
merge = (extendee, extenders...)->
  for extender in extenders
    for own key, val of extender
      extendee[key] = val

  extendee

module.exports = {
  deepFreeze,
  merge
}
