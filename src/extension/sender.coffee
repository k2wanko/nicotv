

do ->
  unless chrome.cast or chrome.cast?.isAvailable

    { include } = require '../lib/util'
    request = require '../lib/request'

    nicotv =
      session: null

    window.nicotv = nicotv

    appId = 'B7864BEC'

    isSuccess = false

    sessionListener = ->
      console.log 'session listener'

    receiverListener = (e)->
      console.log e
      unless e is chrome.cast.ReceiverAvailability.AVAILABLE
        return console.error e


    onInitSuccess = ->
      isSuccess = true
        
    onError = ->
      #ToDo: error function.
      console.error 'on Error', arguments

    onRequestSessionSuccess = (e)->
      console.log e
      nicotv.session = e
      

    requestSession = nicotv.requestSession = ->
      chrome.cast.requestSession(onRequestSessionSuccess, onError);

    initializeCastApi = ->
      sessionRequest = nicotv.sessionRequest = new chrome.cast.SessionRequest appId
      apiConfig = nicotv.apiConfig = new chrome.cast.ApiConfig sessionRequest, sessionListener, receiverListener
      chrome.cast.initialize apiConfig, onInitSuccess, onError
      
    include('https://www.gstatic.com/cv/js/sender/v1/cast_sender.js').onload = ->
      if !chrome.cast or !chrome.cast.isAvailable
        setTimeout initializeCastApi, 1000
