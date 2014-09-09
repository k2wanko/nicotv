
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
  
load_task './tasks/receiver'
gulp.task 'receiver', ['receiver:default'], ->

gulp.task 'watch', ['default'], ->
  gulp.watch './src/**/manifest.yaml', ['extension:manifest']
  gulp.watch './src/**/*.coffee', ['extension:js']
