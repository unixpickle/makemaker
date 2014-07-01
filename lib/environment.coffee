class Environment
  constructor: ->
    required = ['PROJECT_ROOT', 'CXX', 'CC', 'CFLAGS', 'CXXFLAGS',
      'ASM', 'ASMFLAGS']
    for x in required
      if not process.env[x]?
        throw new Error "missing ${x} variable"
    @root = process.env['PROJECT_ROOT']
    @includes = process.env['INCLUDES'] ? ''
    @c = compiler: process.env['CC'], flags: process.env['CFLAGS']
    @cpp = compiler: process.env['CXX'], flags: process.env['CXXFLAGS']
    @asm = compiler: process.env['ASM'], flags: process.env['ASMFLAGS']

module.exports = new Environment()
