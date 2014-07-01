path = require 'path'
fs = require 'fs'

Finder = require './finder'
Makefile = require './makefile'

if process.argv.length isnt 3
  console.log 'Usage: makemaker <build.coffee>'
  process.exit 1

func = require path.resolve process.argv[2]
{makefile, output} = func Finder, Makefile
makefile.generateRules()
result = makefile.encode()
fs.writeFileSync output, result
