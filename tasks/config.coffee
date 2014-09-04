
path = require 'path'

root_dir = process.cwd()

module.exports =
  src: path.join root_dir, 'src/'
  dest: path.join root_dir, 'lib/'
