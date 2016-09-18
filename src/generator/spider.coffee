
readDirectory = (directory, extension) ->
  fs = require "fs"
  path = require "path"
  content = fs.readdirSync directory
  files = []

  for file in content
    filePath = path.resolve directory, file
    stat = fs.statSync filePath
    if stat.isDirectory()
      files = files.concat readDirectory("#{directory}/#{file}", extension)
    else
      if filePath.endsWith(extension)
        files.push
          fullpath: filePath
          filename: file
          path: "#{directory}/#{file}"
          stat: stat
  return files

module.exports =
  scan: (dir, extension) ->
    readDirectory(dir, extension)
