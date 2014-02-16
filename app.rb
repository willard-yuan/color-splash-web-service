$:.unshift File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/reloader' if development?
require 'json'
require 'yaml'
require 'pygments'
require 'lib/color_splash'

helpers do
  # appends a class to a 'a' element if the path variable matches
  # the current page.
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
  @color_splash = Project::ColorSplash.new

  expires 500, :public, :must_revalidate
end

# Home page view that contains a form, which can be used to pygmentize
# a source code.
get '/' do
  @lexer_options = @color_splash.lexers

  erb :index
end

# The "/html" path is the default, therefore it is mapped to "/".
get '/html' do
  redirect to('/')
end

post '/html/generate' do
  output_code = @color_splash.generate params['code'], params['lexer'], params['linenos']

  content_type :json
  { code: output_code }.to_json
end

post '/html/generate/raw' do
  output_code = @color_splash.generate_raw params['code'], params['lexer'], params['linenos']

  content_type :json
  { code: output_code }.to_json
end

get '/stylesheets' do
  @styles = @color_splash.styles

  erb :stylesheets
end

post '/stylesheets/generate' do
  output_code = @color_splash.generate_css params[:theme]

  content_type :json
  { code: output_code }.to_json
end

post '/stylesheets/generate/raw' do
  output_code = @color_splash.generate_css_raw params[:theme]

  content_type :json
  { code: output_code }.to_json
end

# Good old 404 page.
not_found do
  @title = '404 @ Semikols'

  status 404
  erb :not_found
end