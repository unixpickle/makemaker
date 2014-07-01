// Generated by CoffeeScript 1.7.1
(function() {
  var Environment;

  Environment = (function() {
    function Environment() {
      var required, x, _i, _len, _ref;
      required = ['PROJECT_ROOT', 'CXX', 'CC', 'CFLAGS', 'CXXFLAGS', 'ASM', 'ASMFLAGS'];
      for (_i = 0, _len = required.length; _i < _len; _i++) {
        x = required[_i];
        if (process.env[x] == null) {
          throw new Error("missing ${x} variable");
        }
      }
      this.root = process.env['PROJECT_ROOT'];
      this.includes = (_ref = process.env['INCLUDES']) != null ? _ref : '';
      this.c = {
        compiler: process.env['CC'],
        flags: process.env['CFLAGS']
      };
      this.cpp = {
        compiler: process.env['CXX'],
        flags: process.env['CXXFLAGS']
      };
      this.asm = {
        compiler: process.env['ASM'],
        flags: process.env['ASMFLAGS']
      };
    }

    return Environment;

  })();

  module.exports = new Environment();

}).call(this);