function pygmentizeCode() {
  var inputText = document.getElementById('input-text').value;
  var lexer     = document.getElementById('lexer').value;

  reqwest({
    url: '/pygmentize',
    type: 'json',
    method: 'post',
    data: { code: inputText, lexer: lexer },
    error: function (error) {
      document.getElementById('output-text').innerHTML = 'An error occured while pygmenting your code.'
    },
    success: function (response) {
      document.getElementById('output-text').innerHTML = response.code;
    }
  })
}