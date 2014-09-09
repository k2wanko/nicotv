
request = require '../lib/request'
nicoapi = window.nicoapi = require '../lib/nicoapi'

window.onload = ->
  window.player = document.getElementById 'player'
  window.mediaManager = new cast.receiver.MediaManager window.player
  window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()
  window.castReceiverManager.start()
