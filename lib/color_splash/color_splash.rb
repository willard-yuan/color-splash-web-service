require 'yaml'
require 'pygments'

module Project
  # Contains the functionality for the Color Splash project
  class ColorSplash
    attr_reader :title, :lexers

    def initialize
      @title = 'Color Splash'
      @lexers = YAML.load_file 'projects/color_splash/lexers.yml'
    end

    # Public: Wraps a code into HTML tags that can be styled with CSS
    #
    # code - String of code
    # lexer - Language identifier
    # linenos - A flag that indicates whether to generate line numbers.
    #
    # Examples
    #
    #   generate("puts 'Hello, World!'", "ruby", false)
    #   # => '<div class="highlight"><pre><span class="nb">puts</span>
    #         <span class="s1">&#39;Hello, World!&#39;</span></pre></div>'
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
