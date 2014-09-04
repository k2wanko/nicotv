
gulp        = require 'gulp'
gulpif      = require 'gulp-if'
yaml        = require 'gulp-yaml'
browserify  = require 'gulp-browserify'
uglify      = require 'gulp-uglify'
rename      = require 'gulp-rename'

path        = require 'path'

config      = require './config'

DEBUG       = config.DEBUG
src         = path.join(config.src, 'extension')
dest        = path.join(config.dest, 'extension')

gulp.task 'default', ['manifest', 'js'], ->

gulp.task 'manifest', ->
  gulp.src path.join(src, 'manifest.yaml')
  .pipe yaml pretty: DEBUG
  .pipe gulp.dest dest

gulp.task 'js', ->
  gulp.src path.join(src, '*.coffee'), read: false
  .pipe browserify
    transform: ['coffeeify']
    extensions: (ext for ext of require.extensions)
  .pipe gulpif !DEBUG, uglify()
  .pipe rename (path)-> path.extname = '.js'; path
  .pipe gulp.dest dest

gulp.task 'watch', ['default'], ->
  gulp.watch path.join(src, 'manifest.yaml'), ['manifest']
  gulp.watch path.join(src, '*.coffee'), ['js']

#gulp.task 'css', ->
