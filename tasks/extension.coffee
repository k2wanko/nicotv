
gulp =        require 'gulp'
yaml =        require 'gulp-yaml'
browserify =  require 'gulp-browserify'
rename =      require 'gulp-rename'

path = require 'path'

config = require './config'

src  = path.join(config.src, 'extension')
dest = path.join(config.dest, 'extension')

gulp.task 'default', ['manifest', 'js'], ->

gulp.task 'manifest', ->
  gulp.src path.join(src, 'manifest.yaml')
  .pipe yaml()
  .pipe gulp.dest dest

gulp.task 'js', ->
  gulp.src path.join(src, '*.coffee'), read: false
  .pipe browserify
    transform: ['coffeeify']
    extensions: ['.coffee']
  .pipe rename (path)-> path.extname = '.js'; path
  .pipe gulp.dest dest

gulp.task 'css', ->
