$:.unshift File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/reloader' if development?
require 'json'
require 'yaml'

# Require the projects
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

# Good old 404 page.
not_found do
  @title = '404 @ Color Splash'

  status 404
  erb :not_found, layout: :semikols
end

# Load additional routes from all the projects
load 'lib/color_splash/routes.rb'