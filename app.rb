require 'sinatra'
require 'pygments'
require 'json'
require "sinatra/reloader" if development?

get '/' do
  # Available lexers
  @lexer_options = {
    ruby: 'Ruby',
    js: 'JavaScript',
    php: 'PHP',
    python: 'Python',
    powershell: 'PowerShell',
    bash: 'Bash',
    css: 'css',
    html: 'HTML',
    java: 'Java',
    c: 'C',
    cpp: 'C++',
    objectivec: 'Objective-C',
    csharp: 'C#',
    perl: 'Perl',
    scss: 'SCSS'
  }

  @title = 'Color Splash'

  erb :index, layout: :default
end

# Converts a string of code into an HTML with an HTML code that produces a syntax
# highlighted string of code that can be embedded in any HTML document.
#
# code - a String containing a code snippet
# lexer - a programming language identifier
#
# Example
#   POST /pygmentize { 'code': 'puts "Hello, World!"', 'lexer': 'ruby' }
#   # => { 'code': '...here goes the code that can be embedded in an HTML document...' }
#
# Returns JSON
post '/pygmentize' do
  plain_code = params['code']
  lexer = params['lexer']
  pygmented_code = Pygments.highlight(plain_code, lexer: lexer)
  output_code = Pygments.highlight(pygmented_code, lexer: 'html')


  content_type :json
  { code: output_code }.to_json
end


# Converts a string of code into an HTML with a syntax highlighted string of code that
# can be embedded in any HTML document.
#
# code - a String containing a code snippet
# lexer - a programming language identifier
#
# Example
#   POST /pygmentize { 'code': 'puts "Hello, World!"', 'lexer': 'ruby' }
#   # => { 'code': '...here goes the code that can be embedded in an HTML document...' }
#
# Returns JSON
post '/pygmentize/raw' do
  plain_code = params['code']
  lexer = params['lexer']
  pygmented_code = Pygments.highlight(plain_code, lexer: lexer)

  content_type :json
  { code: pygmented_code }.to_json
end

# Good old 404 page.
not_found do
  @title = '404 @ Color Splash'

  status 404
  erb :not_found, layout: :default
end