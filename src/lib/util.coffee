

exports.include = (src)->
  script = document.createElement 'script'
  script.type = 'text/javascript'
  script.src = src if src
  (document.head or document.documentElement).appendChild script
  script
