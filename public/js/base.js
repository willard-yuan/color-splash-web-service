(function() {
  this.pygmentizeCode = function() {
    var inputText, lexer;
    inputText = document.getElementById('input-text').value;
    lexer = document.getElementById('lexer').value;
    return reqwest({
      url: '/pygmentize',
      type: 'json',
      method: 'post',
      data: {
        code: inputText,
        lexer: lexer
      },
      error: function(error) {
        return document.getElementById('output-text').innerHTML = 'An error occured while pygmenting your code.';
      },
      success: function(response) {
        return document.getElementById('output-text').innerHTML = response.code;
      }
    });
  };

}).call(this);
