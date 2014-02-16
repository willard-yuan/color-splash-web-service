require 'yaml'
require 'pygments'

module Project
  # Contains the functionality for the Color Splash project
  class ColorSplash
    attr_reader :title, :lexers, :styles

    def initialize
      @lexers = YAML.load_file 'lib/lexers.yml'
      @styles = Pygments.styles
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
    #   # => HTML coe containing escaped HTML code
    #
    # Returns String
    def generate(code, lexer, linenos)
      if linenos == "true"
        pygmented_code = Pygments.highlight(code, lexer: lexer, options: { linenos: true })
      else
        pygmented_code = Pygments.highlight(code, lexer: lexer)
      end

      Pygments.highlight(pygmented_code, lexer: 'html')
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
    #   # => HTML code
    #
    # Returns String
    def generate_raw(code, lexer, linenos)
      if linenos == "true"
        pygmented_code = Pygments.highlight(code, lexer: lexer, options: { linenos: true })
      else
        pygmented_code = Pygments.highlight(code, lexer: lexer)
      end

      pygmented_code
    end

    # Public: Wraps one of the default Pygments themes into HTML tags that can be
    # styles with CSS and displayed in the web page as HTML code.
    #
    # theme - a String with the Pygments theme name
    #
    # Examples
    #
    #   generate_css 'monokai'
    #   # => HTML code
    #
    # Returns String
    def generate_css(theme)
      stylesheet_code = Pygments.css style: theme

      Pygments.highlight stylesheet_code, lexer: 'css'
    end

    # Public: Wraps one of the default Pygments themes into HTML tags that can be
    # styles with CSS and displayed in the web page as CSS code.
    #
    # theme - a String with the Pygments theme name
    #
    # Examples
    #
    #   generate_css 'monokai'
    #   # => HTML code
    #
    # Returns String
    def generate_css_raw(theme)
      Pygments.css style: theme
    end
  end
end
