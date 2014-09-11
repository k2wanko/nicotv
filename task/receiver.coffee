
gulp        = require 'gulp'
path        = require 'path'

gulpif      = require 'gulp-if'
browserify  = require 'gulp-browserify'
uglify      = require 'gulp-uglify'
rename      = require 'gulp-rename'

jade        = require 'gulp-jade'

config      = require './config'

DEBUG       = config.DEBUG
src         = path.join(config.src, 'receiver')
dest        = path.join(config.dest, 'receiver')


gulp.task 'default', ['js', 'html'], ->

gulp.task 'js', ['coffee'], ->
gulp.task 'coffee', ->
  gulp.src path.join(src, '*.coffee'), read: false
  .pipe browserify
    transform: ['coffeeify']
    extensions: (ext for ext of require.extensions)
  .pipe gulpif !DEBUG, uglify()
  .pipe rename (path)-> path.extname = '.js'; path
  .pipe gulp.dest dest
  
    
gulp.task 'html', ['jade'], ->
gulp.task 'jade', ->
  gulp.src path.join src, '*.jade'
  .pipe jade pretty: DEBUG
  .pipe gulp.dest dest

gulp.task 'watch', ['default'], ->
  gulp.watch path.join(src, '*.coffee'), ['js']
  gulp.watch path.join(src, '*.jade'), ['html']
