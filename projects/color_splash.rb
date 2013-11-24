require 'yaml'
require 'pygments'

module Project
  class ColorSplash
    attr_reader :title, :lexers

    def initialize
      @title = 'Color Splash'
      @lexers = YAML.load_file 'lexers.yml'
    end

    def generate(code, lexer, linenos)
      if linenos == "true"
        pygmented_code = Pygments.highlight(code, lexer: lexer, options: { linenos: true })
      else
        pygmented_code = Pygments.highlight(code, lexer: lexer)
      end

      Pygments.highlight(pygmented_code, lexer: 'html')
    end
  end
end
