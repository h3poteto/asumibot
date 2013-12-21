$ ->
  ready = "#{gon.controller.split('/').join('_')}_#{gon.action}"
  ready += "_#{gon.page}" if gon.page
  gon[ready]() if typeof(gon[ready]) is 'function'