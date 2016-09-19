pug = require "pug"
path = require "path"
fs = require "fs"
mkdirp = require "mkdirp"

render = (template, file, out) ->
  dir = path.join(out, file.path)
  t = "extends #{template}\nblock makiato\n\tinclude:markdown-it(linkify langPrefix='highlight-') #{file.path}"
  html = pug.render t,
    filename: file.filename.replace ".md", ".html"
    basedir: process.cwd()
    pretty: true

  outdir = path.join(process.cwd(), dir.replace(file.filename, ""))
  outdir = path.relative(process.cwd(), outdir)
  if !fs.existsSync outdir
    mkdirp.sync outdir, (err) ->
      if err
        console.error err

  dir = dir.replace(".md", ".html")
  fs.writeFileSync dir, html, null, (err) ->
    if err
      console.error err

gen = (template, dir, extension, out) ->
  spider = require "./spider.js"
  dateformat = require "dateformat"
  files = []
  for file in spider.scan dir, extension
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
    render template, file, out

gen "template.pug","test", ".md", "output"
