require 'sinatra/namespace'

namespace '/color-splash' do
  before do
    @color_splash = Project::ColorSplash.new
    @pages = { html: '/color-splash', css: '/color-splash/stylesheets' }
  end

  get do
    # Available lexers
    @lexer_options = @color_splash.lexers
    @title = 'Color Splash'

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
    output_code = @color_splash.generate params['code'], params['lexer'], params['linenos']

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
    output_code = @color_splash.generate_raw params['code'], params['lexer'], params['linenos']

    content_type :json
    { code: output_code }.to_json
  end

  # A view to generate a CSS code that can be used with Pygments.
  get '/stylesheets' do
    @title = 'CSS @ Color Splash'
    @styles = @color_splash.styles

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
    output_code = @color_splash.generate_css params[:theme]

    content_type :json
    { code: output_code }.to_json
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
    output_code = @color_splash.generate_css_raw params[:theme]

    content_type :json
    { code: output_code }.to_json
  end
end