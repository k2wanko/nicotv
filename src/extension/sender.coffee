

do ->
  unless chrome.cast or chrome.cast?.isAvailable

    { include } = require '../lib/util'
    request = require '../lib/request'
    nicoapi = window.nicoapi = require '../lib/nicoapi'

    appId = 'B7864BEC'

    isSuccess = false

    sessionListener = ->
      console.log 'session listener'

    receiverListener = (e)->
      if e unless chrome.cast.ReceiverAvailability.AVAILABLE
        return console.error e


    onInitSuccess = ->
      isSuccess = true
      vid = nicoapi.idParse window.location.href
      return unless vid
      nicoapi.getflv vid, (e, data, xhr)->
        return console.error e if e
        return unless data?.url?
        url = data.url
        console.log url
        
    onError = ->
      #ToDo: error function.

    initializeCastApi = ->
      sessionRequest = new chrome.cast.SessionRequest appId
      apiConfig = new chrome.cast.ApiConfig sessionRequest, sessionListener, receiverListener
      chrome.cast.initialize apiConfig, onInitSuccess, onError
      
    include('https://www.gstatic.com/cv/js/sender/v1/cast_sender.js').onload = ->
      if !chrome.cast or !chrome.cast.isAvailable
        setTimeout initializeCastApi, 1000
