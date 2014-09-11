
gulp = require 'gulp'
run = require 'gulp-run'

path = require 'path'

config = require './task/config'

{ load_task } = require('./task')

gulp.task 'default', ['extension'], ->

gulp.task 'clean', ->
  run "git clean -f -X -d #{config.dest}"
  .exec()

load_task './task/extension'  
gulp.task 'extension', ['extension:default'], ->
  
load_task './task/receiver'
gulp.task 'receiver', ['receiver:default'], ->

gulp.task 'watch', ['extension:watch', 'receiver:watch'], ->
