this.pygmentizeCode = ->
  inputText = document.getElementById('input-text').value
  lexer     = document.getElementById('lexer').value

  reqwest(
    url: '/pygmentize'
    type: 'json'
    method: 'post'
    data:
      code: inputText
      lexer: lexer
    error: (error)->
      document.getElementById('output-text').innerHTML = 'An error occured while pygmenting your code.'
    success: (response)->
      document.getElementById('output-text').innerHTML = response.code
  )