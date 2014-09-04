
path = require 'path'

root_dir = process.cwd()

module.exports =
  DEBUG: !(process.env.NODE_ENV is 'production')
  src: path.join root_dir, 'src/'
  dest: path.join root_dir, 'lib/'
