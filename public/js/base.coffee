# Public: Calls a service that pygmentizes code.
pygmentizeCode = (editor)->
  url       = document.getElementById('pygmentize-form').action
  inputText = editor.getValue()
  lexer     = document.getElementById('lexer').value
  linenos   = document.getElementById('linenos').checked

  # Indicate that the request is in process
  document.getElementById('pygmentize-submit').classList.add 'loading'

  $.ajax
    url: url
    dataType: 'json'
    type: 'POST'
    data:
      code: inputText
      lexer: lexer
      linenos: linenos
    error: (error)->
      document.getElementById('output-text').innerHTML = 'An error occured while pygmenting your code.'
      document.getElementById('pygmentize-submit').classList.remove 'loading'
    success: (response)->
      document.getElementById('output-text').innerHTML = response.code
      document.getElementById('pygmentize-submit').classList.remove 'loading'

# Public: Calls a service that generates the CSS code for the syntax highlighting.
this.generateStylesheet = ->
  url   = document.getElementById('style-form').action
  theme = document.getElementById('theme').value

  $.ajax
    url: url
    dataType: 'json'
    type: 'POST'
    data:
      theme: theme
    error: (error)->
      document.getElementById('output-text').innerHTML = 'An error occured while generating your CSS.'
    success: (response)->
      document.getElementById('output-text').innerHTML = response.code

$(document).ready ->
  options =
    lineNumbers: true
    tabSize: 2
    mode: "text/x-ruby"
    matchBrackets: true
    autoCloseBrackets: true
    continueComments: "Enter"
    extraKeys: { "Ctrl-Q": "toggleComment" }

  codeMirror = CodeMirror.fromTextArea document.getElementById("input-text"), options

  modes =
    ruby:
      mode: "text/x-ruby"
      file: "/js/mode/ruby/ruby.js"
    js:
      mode: "text/javascript"
      file: "/js/mode/javascript/javascript.js"
    php:
      mode: "text/x-php"
      file: "/js/mode/php/php.js"
    python:
      mode: "text/x-python"
      file: "/js/mode/python/python.js"
    bash:
      mode: "text/x-sh"
      file: "/js/mode/shell/shell.js"
    css:
      mode: "text/css"
      file: "/js/mode/css/css.js"
    html:
      mode: "text/html"
      file: "/js/mode/xml/xml.js"
    java:
      mode: "text/x-java"
      file: "/js/mode/clike/clike.js"
    c:
      mode: "text/x-csrc"
      file: "/js/mode/clike/clike.js"
    cpp:
      mode: "text/x-c++src"
      file: "/js/mode/clike/clike.js"
    csharp:
      mode: "text/x-csharp"
      file: "/js/mode/clike/clike.js"
    perl:
      mode: "text/x-perl"
      file: "/js/mode/perl/perl.js"

  $("#lexer").change (el)->
    selectedMode = @.value
    $.getScript modes[selectedMode]["file"], (data)->
      codeMirror.setOption "mode", modes[selectedMode]["mode"]

  $("#pygmentize-submit").click ->
    pygmentizeCode codeMirror
