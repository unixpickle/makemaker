require 'coffee-script/register' # get better require() function
path = require 'path'
fs = require 'fs'

Finder = require './finder'
Makefile = require './makefile'
Environment = require './environment'

if process.argv.length isnt 3
  console.log 'Usage: makemaker <build.coffee>'
  process.exit 1

func = require path.resolve process.argv[2]

makefile = func Finder, Makefile
makefile.generateRules()

result = makefile.encode()
makeOut = path.join makefile.outRoot, 'Makefile'
fs.writeFileSync makeOut, result
