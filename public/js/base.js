(function() {
  this.pygmentizeCode = function() {
    var inputText, lexer, linenos;
    inputText = document.getElementById('input-text').value;
    lexer = document.getElementById('lexer').value;
    linenos = document.getElementById('linenos').checked;
    return reqwest({
      url: '/color_splash/html/generate',
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
    var theme;
    theme = document.getElementById('theme').value;
    return reqwest({
      url: '/color_splash/stylesheets/generate',
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

}).call(this);
