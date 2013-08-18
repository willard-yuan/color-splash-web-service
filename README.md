# Color Splash

Color Splash is a website and a service that you can use to pygmentize your code.

## The story

I am a big fan of [Jekyll](http://jekyllrb.com) and I use it for two of my blogs. In one of them I write
a lot about programming, therefore I often need to add a code snippets in my posts.
Jekyll makes it very easy, but the more posts you have that uses Jekyll's approach, the more
difficult it would be to migrate to another platform. There is also a problem with Windows. It can be resolved,
but if you are not a technical person, it is a pain in the ass.

A while ago I decided not to use the Jekyll's support for pygments and started to generate all the necessary
HTML directly with Pygments. It solved one of the problems, but it still requires you to have Python and Pygments
installed and configured correctly. If you are on Windows, you do not want to do that (believe me, I know).

Color Splash was born in one day out of my frustration with Python (no offence, pythonistas), and it resolves
all of my problems with code snippets. You still get the power and flexibility of Pygments, but you do not need
to worry about all the dependencies.

## Usage

There are 3 ways you can use Color Splash:

- Use it directly from the site (doh!).
- Use it as a service by posting to the `http://color-splash.semikols.lv/pygmentize/raw` URL and sending a JSON object with `code` and `lexer` keys.
- Fork it and create your own service :)

## TODO

- Add more lexers.
- Add an option to generate a CSS file.
- Create a better design.

You can always find me on Twitter as [@aigarsdz](http://twitter.com/aigarsdz).
