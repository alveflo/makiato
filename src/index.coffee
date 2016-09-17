#!/usr/bin/env node
program = require "commander"
pjson = require "../package.json"

program
  .version(pjson.version)
  .option("brew",       "Generate web site")
  .parse(process.argv)

if (program.brew)
  console.log "Brewing web site..."
