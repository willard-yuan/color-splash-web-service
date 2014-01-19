$:.unshift File.dirname(__FILE__)

require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?

require 'lib/color_splash/color_splash'

helpers do
  # appends a class to a 'a' element if the path variable matches the current page.
  #
  # path - the path of the page
  #
  # Example
  #
  #   request.path_info
  #   # => /blog
  #
  #   current '/blog'
  #   # => true
  #
  # Returns a string.
  def current(path = '')
    request.path_info == path
  end
end

configure do
  enable :cross_origin
end

before do
  expires 500, :public, :must_revalidate

  @pages = { html: '/color-splash', css: '/color-splash/stylesheets' }
  @color_splash = Project::ColorSplash.new
end

# Home page view.
get '/' do
  @projects = [{
    id: 'color_splash',
    title: 'Color Splash',
    url: '/color-splash',
    image: '/images/color_splash_3.png'
  }]

  erb :"semikols/index", layout: :semikols
end

namespace '/color-splash' do
  get do
    # Available lexers
    @lexer_options = @color_splash.lexers
    @title = @color_splash.title

    erb :"color_splash/index", layout: :color_splash
  end

  # A view to pygmentize the code.
  get '/html' do
    redirect to('/color_splash')
  end

  # Converts a string of code into an HTML with an HTML code that produces a syntax
  # highlighted string of code that can be embedded in any HTML document.
  #
  # code - a String containing a code snippet
  # lexer - a programming language identifier
  #
  # Example
  #   POST /color_splash/html/generate { 'code': 'puts "Hello, World!"', 'lexer': 'ruby' }
  #   # => { 'code': '...here goes the code that can be embedded in an HTML document...' }
  #
  # Returns JSON
  post '/html/generate' do
    output_code = @color_splash.generate(params['code'], params['lexer'], params['linenos'])

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
  #   POST /color_splash/html/generate/raw { 'code': 'puts "Hello, World!"', 'lexer': 'ruby' }
  #   # => { 'code': '...here goes the code that can be embedded in an HTML document...' }
  #
  # Returns JSON
  post '/html/generate/raw' do
    if params['linenos'] == "true"
      pygmented_code = Pygments.highlight(params['code'], lexer: params['lexer'],
        options: { linenos: true })
    else
      pygmented_code = Pygments.highlight(params['code'], lexer: params['lexer'])
    end

    content_type :json
    { code: pygmented_code }.to_json
  end

  # A view to generate a CSS code that can be used with Pygments.
  get '/stylesheets' do
    @title = 'CSS @ Color Splash'
    @styles = Pygments.styles

    erb :"color_splash/stylesheets", layout: :color_splash
  end

  # Uses Pygments built in functionality to generate a CSS code. After that it is
  # highlighted to be embeded in an HTML document.
  #
  # theme - a CSS them that is going to be generated
  #
  # Example
  #   POST /color_splash/stylesheets/generate { 'theme': 'monokai' }
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
  #   POST /color_splash/stylesheets/generate { 'theme': 'monokai' }
  #   # => { 'code': ---here goes the CSS code... }
  #
  # Returns JSON
  post '/stylesheets/generate/raw' do
    stylesheet_code = Pygments.css style: params[:theme]

    content_type :json
    { code: stylesheet_code }.to_json
  end
end

# Good old 404 page.
not_found do
  @title = '404 @ Color Splash'

  status 404
  erb :not_found, layout: :semikols
end
