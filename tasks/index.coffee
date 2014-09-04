
gulp = require 'gulp'
path = require 'path'

isArray = Array.isArray or (obj)->
  toString.call(obj) is '[object Array]'

exports.load_task = (target, namespace)->
  
  throw new Error "Cannot find task" unless target
  
  target = path.join path.dirname(module.parent.filename), target
  namespace = namespace or path.basename target, path.extname(target)
  tasks = []
  
  join = (task_name)->
    namespace + ':' + task_name
    
  _task = gulp.task
  gulp.task = (name, deps, fn)->
    [fn, deps] = [deps, fn] unless fn
    name = join name    
    deps = ( for task in deps then join task ) if isArray deps
    _fn = new ->
      @_fn = fn
      self = @
      ->
        _watch = @watch
        @watch = (glob, opts, tasks)->
          [tasks, opts] = [opts, tasks] unless tasks
          tasks = ( for task in tasks then join task ) if isArray tasks
          _watch.call @, glob, opts, tasks
        self._fn.apply @, arguments
        @watch = _watch
    tasks.push name unless tasks.indexOf(name) < 0
    _task.call @, name, deps, _fn

  _watch = gulp.watch
  gulp.watch = (glob, opts, tasks)->
    [tasks, opts] = [opts, tasks] unless tasks

    tasks = for task in tasks
      join name, task
    console.log glob, opts, tasks
    _watch.apply @, glob, opts, tasks

  require target
  
  gulp.task = _task
  gulp.watch = _watch

  tasks
