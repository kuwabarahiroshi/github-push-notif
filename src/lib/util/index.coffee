# Utility library

# Freeze object recursively.
#
# @param [Object] obj Object to be frozen.
# @return [Object] obj Returns given object itself.
deepFreeze = (obj) ->
  # freeze given object itself.
  Object.freeze obj

  #recursively freeze object properties.
  for own key, val of obj
    continue unless typeof val is 'object'
    continue if Object.isFrozen val
    deepFreeze val

  obj

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

#
# export APIs
#
module.exports = {
  deepFreeze,
  merge
}
