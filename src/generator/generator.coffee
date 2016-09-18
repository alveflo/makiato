gen = (dir, extension, out) ->
  spider = require "./spider.js"
  dateformat = require "dateformat"
  files = []
  for file in spider.scan(dir, extension)
    title = file.filename.replace extension, ""
    title = title.replace\
      (file.filename.charAt(0)
      ,file.filename.charAt(0).toUpperCase())

    files.push
      fullpath: file.path
      created: dateformat file.stat.birthtime, "yyyy-mm-dd"
      year: dateformat file.stat.birthtime, "yyyy"
      month: dateformat file.stat.birttime, "mmmm"
      url: file.path.replace(dir, "").replace(extension, ".html")
      title: title
  console.log files

gen("test", ".md", "output")
