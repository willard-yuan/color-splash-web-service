(function() {
  this.pygmentizeCode = function() {
    var inputText, lexer, linenos, url;
    url = document.getElementById('pygmentize-form').action;
    inputText = document.getElementById('input-text').value;
    lexer = document.getElementById('lexer').value;
    linenos = document.getElementById('linenos').checked;
    return reqwest({
      url: url,
      type: 'json',
      method: 'post',
      data: {
        code: inputText,
        lexer: lexer,
        linenos: linenos
      },
      error: function(error) {
        return document.getElementById('output-text').innerHTML = 'An error occured while pygmenting your code.';
      },
      success: function(response) {
        return document.getElementById('output-text').innerHTML = response.code;
      }
    });
  };

  this.generateStylesheet = function() {
    var theme, url;
    url = document.getElementById('style-form').action;
    theme = document.getElementById('theme').value;
    return reqwest({
      url: url,
      type: 'json',
      method: 'post',
      data: {
        theme: theme
      },
      error: function(error) {
        return document.getElementById('output-text').innerHTML = 'An error occured while generating your CSS.';
      },
      success: function(response) {
        return document.getElementById('output-text').innerHTML = response.code;
      }
    });
  };

  $(document).ready(function() {
    var codeMirror, modes, options;
    options = {
      lineNumbers: true,
      tabSize: 2,
      mode: "text/x-ruby",
      matchBrackets: true,
      autoCloseBrackets: true,
      continueComments: "Enter",
      extraKeys: {
        "Ctrl-Q": "toggleComment"
      }
    };
    codeMirror = CodeMirror.fromTextArea(document.getElementById("input-text"), options);
    modes = {
      ruby: {
        mode: "text/x-ruby",
        file: "/js/mode/ruby/ruby.js"
      },
      js: {
        mode: "text/javascript",
        file: "/js/mode/javascript/javascript.js"
      },
      php: {
        mode: "text/x-php",
        file: "/js/mode/php/php.js"
      },
      python: {
        mode: "text/x-python",
        file: "/js/mode/python/python.js"
      },
      powershell: {
        mdoe: "text/x-powershell",
        file: "/js/mode/powershell/powershell.js"
      },
      bash: {
        mode: "text/x-sh",
        file: "/js/mode/shell/shell.js"
      },
      css: {
        mode: "text/css",
        file: "/js/mode/css/css.js"
      },
      html: {
        mode: "text/html",
        file: "/js/mode/htmlmixed/htmlmixed.js"
      },
      java: {
        mode: "text/x-java",
        file: "/js/mode/clike/clike.js"
      },
      c: {
        mode: "text/x-csrc",
        file: "/js/mode/clike/clike.js"
      },
      cpp: {
        mode: "text/x-c++src",
        file: "/js/mode/clike/clike.js"
      },
      csharp: {
        mode: "text/x-csharp",
        file: "/js/mode/clike/clike.js"
      },
      perl: {
        mode: "text/x-perl",
        file: "/js/mode/perl/perl.js"
      }
    };
    return $("#lexer").change(function(el) {
      var selectedMode;
      selectedMode = this.value;
      return $.getScript(modes[selectedMode]["file"], function(data) {
        return codeMirror.setOption("mode", modes[selectedMode]["mode"]);
      });
    });
  });

}).call(this);
