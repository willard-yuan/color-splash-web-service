require 'sinatra'
require 'pygments'
require 'json'
require "sinatra/reloader" if development?

helpers do
  def h(text)
    Rack::Utils.escape_html text
  end
end

get '/' do
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

  erb :index
end

post '/pygmentize' do
  plain_code = params['code']
  lexer = params['lexer']
  pygmented_code = Pygments.highlight(plain_code, lexer: lexer)
  output_code = Pygments.highlight(pygmented_code, lexer: 'html')


  content_type :json
  { code: output_code }.to_json
end

post '/pygmentize/raw' do
  plain_code = params['code']
  lexer = params['lexer']
  pygmented_code = Pygments.highlight(plain_code, lexer: lexer)

  content_type :json
  { code: pygmented_code }.to_json
end