require 'sinatra'
require 'pry-remote' if development?
require File.expand_path '../app.rb', __FILE__

run Sinatra::Application