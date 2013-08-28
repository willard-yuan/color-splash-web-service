require 'sinatra'
require 'pygments'
require 'json'
require 'sinatra/cross_origin'
require "sinatra/reloader" if development?

helpers do
  # appends a class to an 'a' element if the path variable matches the current page.
  #
  # path - the path of the page
  #
  # Example
  #
  #   request.path_info
  #   # => /blog
  #
  #   current '/blog'
  #   # => class="current_path"
  #
  # Returns a string.
  def current(path = '')
    request.path_info == path ? 'class="current_page"' : nil
  end
end

configure do
  enable :cross_origin
end

before do
  expires 500, :public, :must_revalidate

  @pages = { html: '/', css: '/stylesheets' }
end

# Home page view.
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

# A view to pygmentize the code.
get '/html' do
  redirect to('/')
end

# Converts a string of code into an HTML with an HTML code that produces a syntax
# highlighted string of code that can be embedded in any HTML document.
#
# code - a String containing a code snippet
# lexer - a programming language identifier
#
# Example
#   POST /html/generate { 'code': 'puts "Hello, World!"', 'lexer': 'ruby' }
#   # => { 'code': '...here goes the code that can be embedded in an HTML document...' }
#
# Returns JSON
post '/html/generate' do
  pygmented_code = Pygments.highlight(params['code'], lexer: params['lexer'])
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
#   POST /html/generate/raw { 'code': 'puts "Hello, World!"', 'lexer': 'ruby' }
#   # => { 'code': '...here goes the code that can be embedded in an HTML document...' }
#
# Returns JSON
post '/html/generate/raw' do
  pygmented_code = Pygments.highlight params['code'], lexer: params['lexer']

  content_type :json
  { code: pygmented_code }.to_json
end

# A view to generate a CSS code that can be used with Pygments.
get '/stylesheets' do
  @title = 'CSS @ Color Splash'
  @styles = Pygments.styles

  erb :stylesheets, layout: :default
end

# Uses Pygments built in functionality to generate a CSS code. After that it is
# highlighted to be embeded in an HTML document.
#
# theme - a CSS them that is going to be generated
#
# Example
#   POST /stylesheets/generate { 'theme': 'monokai' }
#   # => { 'code': ---here goes the HTML code... }
#
# Returns JSON
post '/stylesheets/generate' do
  stylesheet_code = Pygments.css style: params[:theme]
  pygmented_stylesheet_code = Pygments.highlight stylesheet_code, lexer: 'css'

  content_type :json
  { code: pygmented_stylesheet_code }.to_json
end

# Uses Pygments built in functionality to generate a CSS code.
#
# theme - a CSS them that is going to be generated
#
# Example
#   POST /stylesheets/generate { 'theme': 'monokai' }
#   # => { 'code': ---here goes the CSS code... }
#
# Returns JSON
post '/stylesheets/generate/raw' do
  stylesheet_code = Pygments.css style: params[:theme]

  content_type :json
  { code: stylesheet_code }.to_json
end

# Good old 404 page.
not_found do
  @title = '404 @ Color Splash'

  status 404
  erb :not_found, layout: :default
end