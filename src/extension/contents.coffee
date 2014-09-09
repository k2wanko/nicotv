
{ include } = require '../lib/util'

getUrl = (path)->
  'chrome-extension://' + chrome.runtime.id + '/' + path

window.addEventListener 'load', ->
  include getUrl 'sender.js'
  
