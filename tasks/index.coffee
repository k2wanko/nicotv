
gulp = require 'gulp'
path = require 'path'

exports.load_task = (target, name)->
  
  throw new Error "Cannot find task" unless target
  
  target = path.join path.dirname(module.parent.filename), target
  name = name or path.basename target, path.extname(target)
  tasks = []
  
  _ = gulp.task
  gulp.task = ->
    arguments[0] = name + ':' + arguments[0]
    tasks.push name unless tasks.indexOf(name) < 0
    _.apply @, arguments

  require target
  
  gulp.task = _

  tasks
