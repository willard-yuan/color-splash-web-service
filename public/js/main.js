var pygmentizeCode;pygmentizeCode=function(e){var t,n,o,r;return r=document.getElementById("pygmentize-form").action,t=e.getValue(),n=document.getElementById("lexer").value,o=document.getElementById("linenos").checked,document.getElementById("pygmentize-submit").classList.add("loading"),$.ajax({url:r,dataType:"json",type:"POST",data:{code:t,lexer:n,linenos:o},error:function(){return document.getElementById("output-text").innerHTML="An error occured while pygmenting your code.",document.getElementById("pygmentize-submit").classList.remove("loading")},success:function(e){return document.getElementById("output-text").innerHTML=e.code,document.getElementById("pygmentize-submit").classList.remove("loading")}})},this.generateStylesheet=function(){var e,t;return t=document.getElementById("style-form").action,e=document.getElementById("theme").value,$.ajax({url:t,dataType:"json",type:"POST",data:{theme:e},error:function(){return document.getElementById("output-text").innerHTML="An error occured while generating your CSS."},success:function(e){return document.getElementById("output-text").innerHTML=e.code}})},$(document).ready(function(){var e,t,n;return n={lineNumbers:!0,tabSize:2,mode:"text/x-ruby",matchBrackets:!0,autoCloseBrackets:!0,continueComments:"Enter",extraKeys:{"Ctrl-Q":"toggleComment"}},e=CodeMirror.fromTextArea(document.getElementById("input-text"),n),t={ruby:{mode:"text/x-ruby",file:"/js/mode/ruby/ruby.js"},js:{mode:"text/javascript",file:"/js/mode/javascript/javascript.js"},php:{mode:"text/x-php",file:"/js/mode/php/php.js"},python:{mode:"text/x-python",file:"/js/mode/python/python.js"},bash:{mode:"text/x-sh",file:"/js/mode/shell/shell.js"},css:{mode:"text/css",file:"/js/mode/css/css.js"},html:{mode:"text/html",file:"/js/mode/xml/xml.js"},java:{mode:"text/x-java",file:"/js/mode/clike/clike.js"},c:{mode:"text/x-csrc",file:"/js/mode/clike/clike.js"},coffeescript:{mode:"text/x-coffeescript",file:"/js/mode/coffeescript/coffeescript.js"},cpp:{mode:"text/x-c++src",file:"/js/mode/clike/clike.js"},csharp:{mode:"text/x-csharp",file:"/js/mode/clike/clike.js"},perl:{mode:"text/x-perl",file:"/js/mode/perl/perl.js"}},$("#lexer").change(function(){var n;return n=this.value,$.getScript(t[n].file,function(){return e.setOption("mode",t[n].mode)})}),$("#pygmentize-submit").click(function(){return pygmentizeCode(e)})});