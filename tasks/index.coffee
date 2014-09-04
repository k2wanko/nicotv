
gulp = require 'gulp'
path = require 'path'

isArray = Array.isArray or (obj)->
  toString.call(obj) is '[object Array]'

exports.load_task = (target, name)->
  
  throw new Error "Cannot find task" unless target
  
  target = path.join path.dirname(module.parent.filename), target
  name = name or path.basename target, path.extname(target)
  tasks = []
  
  _ = gulp.task
  gulp.task = ->
    arguments[0] = name + ':' + arguments[0]
    if isArray(arguments[1])
      arguments[1] = do (deps = arguments[1])->
        for dep in deps
          name + ':' + dep
    tasks.push name unless tasks.indexOf(name) < 0
    _.apply @, arguments

  require target
  
  gulp.task = _

  tasks
