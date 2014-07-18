path = require 'path'
env = require './environment'

class Makefile
  constructor: (@finder, @includes, @outRoot) ->
    @rules = {}
    @addedFlags = c: '', cpp: '', asm: ''
  
  addFlags: (language, flags) ->
    if @addedFlags[language].length is 0
      @addedFlags[language] = flags
    else
      @addedFlags[language] += ' ' + flags
  
  generateRules: ->
    @_generateWithVars @finder.cSources, env.c, @addedFlags.c
    @_generateWithVars @finder.cppSources, env.cpp, @addedFlags.cpp
    @_generateWithVars @finder.asmSources, env.asm, @addedFlags.asm, false
  
  encode: ->
    result = 'all: ' + (x for own x of @rules).join(' ') + '\n\n'
    for own aPath, info of @rules
      result += aPath + ': ' + info.deps + '\n'
      result += '\t' + info.command + '\n\n'
    return result
  
  _addRule: (outPath, deps, command) ->
    return if @rules[outPath]?
    @rules[outPath] =
      deps: deps
      command: command
  
  _generateWithTemplate: (files, template) ->
    for file in files
      output = path.join @outRoot, @_simplifyName file
      output = output.replace /\.[a-z]*$/, '.o'
      input = path.join env.root, file
      command = template.replace('%OUT', output).replace '%IN', input
      @_addRule output, input, command
  
  _generateWithVars: (files, envInfo, added, extraFlags = true) ->
    {compiler, flags} = envInfo
    if extraFlags
      includes = @_getIncludes()
      command = "#{compiler} -c #{flags} #{added} #{includes} %IN -o %OUT"
    else
      command = "#{compiler} #{flags} #{added} %IN -o %OUT"
    @_generateWithTemplate files, command
  
  _simplifyName: (name) ->
    return name.replace(/\//g, '_').replace '..', '__'
  
  _getIncludes: ->
    val = env.includes
    for aPath in @includes
      val += ' ' if val.length
      val += '-I' + path.join env.root, aPath
    return val

module.exports = Makefile
