
gulp = require 'gulp'
run = require 'gulp-run'

path = require 'path'

config = require './tasks/config'

{ load_task } = require('./tasks')

gulp.task 'default', ['extension'], ->

gulp.task 'clean', ->
  run "git clean -f -X -d #{config.dest}"
  .exec()

load_task './tasks/extension'  
gulp.task 'extension', ['extension:default'], ->

gulp.task 'receiver', ->
