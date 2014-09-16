
request = require '../lib/request'
nicoapi = window.nicoapi = require '../lib/nicoapi'

window.onload = ->
  
  cast.receiver.logger.setLevelValue cast.receiver.LoggerLevel.DEBUG

  console.log 'Starting media application'
  window.player = document.getElementById 'player'
  window.mediaManager = new cast.receiver.MediaManager window.player
  window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()
  bus = castReceiverManager.getCastMessageBus('urn:x-cast:jp.nicotv')
  window.castReceiverManager.onSenderDisconnected = (e)->
    console.log 'sender disconnected'
    
  window.castReceiverManager.start()
