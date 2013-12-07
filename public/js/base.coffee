this.pygmentizeCode = ->
  inputText = document.getElementById('input-text').value
  lexer     = document.getElementById('lexer').value
  linenos   = document.getElementById('linenos').checked

  reqwest(
    url: '/color-splash/html/generate'
    type: 'json'
    method: 'post'
    data:
      code: inputText
      lexer: lexer
      linenos: linenos
    error: (error)->
      document.getElementById('output-text').innerHTML = 'An error occured while pygmenting your code.'
    success: (response)->
      document.getElementById('output-text').innerHTML = response.code
  )

this.generateStylesheet = ->
  theme = document.getElementById('theme').value

  reqwest(
    url: '/color-splash/stylesheets/generate'
    type: 'json'
    method: 'post'
    data:
      theme: theme
    error: (error)->
      document.getElementById('output-text').innerHTML = 'An error occured while generating your CSS.'
    success: (response)->
      document.getElementById('output-text').innerHTML = response.code
  )
