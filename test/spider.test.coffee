test "Scan /md should return 3 files", () ->
  spider = require "../lib/generator/spider.js"
  path = require "path"
  res = spider.scan path.join(process.cwd(), "__test__/md"), ".md"
  expect(res.length).toBe 3
