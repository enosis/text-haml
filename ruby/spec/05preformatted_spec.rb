#05preformatted_spec.rb
#./text-haml/ruby/spec/
#Calling: spec --color 05preformatted_spec.rb -f s
#Authors:
# enosis@github.com Nick Ragouzis - Last: Sept2010
#
#Correspondence:
# Haml_WhitespaceSemanticsExtension_ImplmentationNotes v0.2, 12Sept 2010
#

require "HamlRender"

var1 = "variable1"
var2 = "   variable2  \n  twolines   "

def expr1(arg = "expr1arg" )
  "__" + arg + "__"
end

#Notice: With Whitespace Semantics Extension (WSE), OIR:loose is the default 
#Notice: Trailing whitespace is present on some Textlines


#================================================================
describe HamlRender, "-01- Preformatted:" do
  it "%pre +observe BlockLeftMargin, with nested content" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['textarea', 'code'],
                 :preformatted => ['ver', 'pre', 'code' ],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%pre
  o           .'`/
      '      /  (
    O    .-'` ` `'-._      .')
       _/ (o)        '.  .' /
       )       )))     ><  <
       `\  |_\      _.'  '. \
         `-._  _ .-'       `.)
     jgs     `\__\
%p 
  =link_to 'HTML5 Content Models', http://dev.w3.org/html5/spec/content-models.html
  from
  =link_to 'Joan G. Stark', http://webspace.webring.com/people/cu/um_3734/aquatic.htm
HAML
      wspc.html.should == <<'HTML'
<pre>
  o           .'`/
      '      /  (
    O    .-'` ` `'-._      .')
       _/ (o)        '.  .' /
       )       )))     ><  <
       `\  |_\      _.'  '. \
         `-._  _ .-'       `.)
     jgs     `\__\
</pre>
<p>
  <a href="http://dev.w3.org/html5/spec/content-models.html">HTML5 Content Models</a>, 
  from <a href="http://webspace.webring.com/people/cu/um_3734/aquatic.htm">Joan G. Stark</a>
</p>
HTML
    end
  end
end
#Illegal nesting


#================================================================
describe HamlRender, "-02- Preformatted:" do
  it "%pre +NOTobserve BlockLeftMargin: requires HereDoc" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['textarea', 'code'],
                 :preformatted => ['ver', 'pre', 'code'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%argh
  %pre<<POEM
       Higher still and higher
         From the earth thou springest
       Like a cloud of fire;
         The blue deep thou wingest,
And singing still dost soar, and soaring ever singest.
POEM
  %p 
    =link_to 'HTML4.01 Paragraphs, Lines, and Phrases', http://www.w3.org/TR/html401/struct/text.html
    citing Shelly, 
    %succeed '.'  
      %em To a Skylark
HAML
      wspc.html.should == <<HTML
<argh>
  <pre>
       Higher still and higher
         From the earth thou springest
       Like a cloud of fire;
         The blue deep thou wingest,
And singing still dost soar, and soaring ever singest.
  </pre>
  <p>
    <a href="http://www.w3.org/TR/html401/struct/text.html">HTML4.01 Paragraphs, Lines, and Phrases</a>
    citing Shelly, <em>To a Skylark</em>.
  </p>.
</argh>
HTML
    end
  end
end


#================================================================
describe HamlRender, "-03- Preformatted:" do
  it "%pre +NOTobserve BlockLeftMargin: requires HereDoc, using <<-" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['textarea', 'code'],
                 :preformatted => ['ver', 'pre', 'code' ],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%tex
  %pre<<-DEK
Roses are red,
  Violets are blue;
Rhymes can be typeset
  With boxes and glue.
                      DEK
  = succeed(".")
    %p Donald E. Knuth, 1984, 
      %em The TEXbook
HAML
      wspc.html.should == <<HTML
<tex>
  <pre>
Roses are red,
  Violets are blue;
Rhymes can be typeset
  With boxes and glue.
                  DEK
  </pre>
  <p>Donald E. Knuth, 1984, <em>The TEXbook</em></pm></p>.
</tex>
HTML
    end
  end
end

#================================================================
describe HamlRender, "-04- Preformatted:" do
  it "%code Legacy Illeg. Nesting.  option:preformatted over preserve - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['textarea', 'code'],
                 :preformatted => ['ver', 'pre', 'code' ],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%zap
  %code
    def fact(n)  
      (1..n).reduce(1, :*)  
    end  
%spin
  %code  accept:
         do
         :: np_
         od
HAML
      wspc.html.should == <<HTML
<zap>
  <code>
    def fact(n)  
      (1..n).reduce(1, :*)  
    end  
  </code>
</zap>
<spin>
 accept:
     do
     :: np_
     od
</spin>
HTML
    end
  end
end

