#00ImplementationNotes_spec.rb
#./text-haml/ruby/spec/
#Calling: spec --color 00ImplementationNotes_spec.rb -f s
#Authors: 
# enosis@github.com Nick Ragouzis - Last: Sept2010
#
#Correspondence:
# Haml_WhitespaceSemanticsExtension_ImplmentationNotes v0.2, 12Sept 2010
#

require "HamlRender"

var1 = "variable1"
var2 = "variable2  \ntwolines   "

def expr1(arg = "expr1arg" )
  "__" + arg + "__"
end

#Notice: With Whitespace Semantics Extension (WSE), OIR:loose is the default 
#Notice: Trailing whitespace is present on some Textlines


#================================================================
describe HamlRender, "Shiny Things -01- Implementation Notes:" do
  it "gee whiz" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%gee
  %whiz
    Wow this is cool!
HAML
      wspc.html.should == <<HTML
<gee>
  <whiz>
    Wow this is cool!
  </whiz>
</gee>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Motivation -01- Implementation Notes:" do
  it "foo bar baz bang boom - legacy Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%foo
  %bar
    %baz
      bang
    boom
HAML
      wspc.html.should == <<HTML
<foo>
  <bar>
    <baz>
      bang
    </baz>
    boom
  </bar>
</foo>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Motivation -02- Implementation Notes:" do
  it "foo bar baz bang boom - WSE Haml, following Nex3 Issue 28" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%foo
  %bar
      %baz
        bang
      boom
HAML
      wspc.html.should == <<HTML
<foo>
  <bar>
    <baz>
      bang
    </baz>
    boom
  </bar>
</foo>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Motivation -03- Implementation Notes:" do
  it "foo up four down two - following Nex3 Issue 28, legacy Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      lambda {wspc.render_haml( <<'HAML', h_opts )}.should raise_error(Haml::SyntaxError,/Inconsistent indentation/)
%foo
    up four spaces
  down two spaces
HAML
      wspc.html.should == nil
    #end
  end
end
#Legacy Haml
#Inconsistent indentation: 2 spaces were used for indentation, but the rest of the document was indented using 4 spaces.
#In WSE Haml, this should 'fail' because it will not raise the SyntaxError


#================================================================
describe HamlRender, "Motivation -04- Implementation Notes:" do
  it "foo up four down two - following Nex3 Issue 28, WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%foo
    up four spaces
  down two spaces
HAML
      wspc.html.should == <<HTML
<foo>
    up four spaces
  down two spaces
</foo>
HTML
    end
  end
end


#================================================================
describe HamlRender, "WSE In Brief -01- Implementation Notes:" do
  it "cblock1, cblock2 indent nesting" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div#id1
    %p cblock2
    %p cblock3
%div#id2
  %p cblock4 
       cblock4 nested
HAML
      wspc.html.should == <<HTML
<div id='id1'>
  <p>cblock2</p>
  <p>cblock3</p>
</div>
<div id='id2'>
  <p>cblock4 
    cblock4 nested
  </p>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "WSE In Brief -02- Implementation Notes:" do
  it "cblock1, cblock2 UNDENT nesting" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
    %p cblock2 
       cblock4 nested
    %p cblock3
  %p cblock4
HAML
      wspc.html.should == <<HTML
<div>
  <p>cblock2
    cblock4 nested
  </p>
  <p>cblock3</p>
  <p>cblock4</p>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Lexing and Syntactics -01- Implementation Notes:" do
  it "Haml-as a Macro Language -- lexer tolerance" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      lambda {wspc.render_haml( <<'HAML' , h_opts, 'varstr' => 'TextStr' )}.should raise_error(Haml::SyntaxError,/Unbalanced brackets/)
%div
    %p #{varstr
HAML
      wspc.html.should == nil
    #end
  end
end


#================================================================
describe HamlRender, "Lexing and Syntactics -02- Implementation Notes:" do
  it "Haml-as a Macro Language -- lexer tolerance - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts, 'varstr' => 'TextStr' )
%div
    %p #{varstr
HAML
      wspc.html.should == <<'HTML'
<div>
  <p>#{varstr</p>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Coarse Hierarchy -01- Implementation Notes:" do
  it "Multiline -- Two blocks whiteline demarked" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%foo
  First |
  Block |

  Second |
  Block |
HAML
      wspc.html.should == <<'HTML'
<foo>
  First Block
  Second Block
</foo>
HTML
    end
  end
end
#Legacy Haml
#<foo>\n  First Block Second Block \n</foo>


#================================================================
describe HamlRender, "Coarse Hierarchy -02- Implementation Notes:" do
  it "Multiline -- Two blocks whiteline demarked" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%foo
  First |
  Block |
  -# Haml Comment    # WSE processing model changes the AST
  Second |
  Block |
HAML
      wspc.html.should == <<'HTML'
<foo>
  First Block Second Block
</foo>
HTML
    end
  end
end
#Legacy Haml
#<foo>\n  First Block \n  Second Block \n</foo>


#================================================================
describe HamlRender, "Coarse Hierarchy -03- Implementation Notes:" do
  it "Multiline -- Two blocks, Multiple Whitelines - consolidated" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%foo
  First |
  Block |


  Second |
  Block |
HAML
      wspc.html.should == <<'HTML'
<foo>
  First Block 

  Second Block
</foo>
HTML
    end
  end
end
#Legacy Haml
#<foo>\n  First Block Second Block \n</foo>


#================================================================
describe HamlRender, "Elements -01- Implementation Notes:" do
  it "Basic Element" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%p
  Text
HAML
      wspc.html.should == <<'HTML'
<p>
  Text
</p>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Elements -02- Implementation Notes:" do
  it "cblock1 span cblock2" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %p
    cblock1
    %span cblock2
HAML
      wspc.html.should == <<'HTML'
<div>
  <p>
    cblock1
    <span>cblock2</span>
  </p>
</div>
HTML
    #end
  end
end
#<div>\n  <p>\n    cblock1\n    <span>cblock2</span>\n  </p>\n</div>


#================================================================
describe HamlRender, "Indentation -01- Implementation Notes:" do
  it "Standard Legacy 2-space IndentStep" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%HEAD1
  %HEAD2
    %HEAD3
      Content1
      Content2
  UNDENTLINE
HAML
      wspc.html.should == <<'HTML'
<HEAD1>
  <HEAD2>
    <HEAD3>
      Content1
      Content2
    </HEAD3>
  </HEAD2>
  UNDENTLINE
</HEAD1>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Indentation -02- Implementation Notes:" do
  it "cblock1, cblock2, cblock3, cblock4 Standard Legacy" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %div#id1
    %p cblock1
    %div#a
      %p cblock2
      %p
        cblock3
  %div#id2
    %p cblock4
HAML
      wspc.html.should == <<'HTML'
<div>
  <div id='id1'>
    <p>cblock1</p>
    <div id='a'>
      <p>cblock2</p>
      <p>
        cblock3
      </p>
    </div>
  </div>
  <div id='id2'>
    <p>cblock4</p>
  </div>
</div>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Indentation -03- Implementation Notes:" do
  it "div-cblocks - OIR:strict" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %div#id1
     %div#a cblock1
     %div#b
         cblock2
         %p
            cblock3
  %div#id2
      %p cblock4
HAML
      wspc.html.should == <<'HTML'
<div>
  <div id='id1'>
    <div id='a'>cblock1</div>
    <div id='b'>
      cblock2
      <p>
        cblock3
      </p>
    </div>
  </div>
  <div id='id2'>
    <p>cblock4</p>
  </div>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Indentation -04- Implementation Notes:" do
  it "div-cblocks edited - OIR:strict" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %div#id1
     %div#a cblock1
     %div#b
            cblock3
  %div#id2
      %p cblock4
HAML
      wspc.html.should == <<'HTML'
<div>
  <div id='id1'>
    <div id='a'>cblock1</div>
    <div id='b'>
      cblock3
    </div>
  </div>
  <div id='id2'>
    <p>cblock4</p>
  </div>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Indentation -05- Implementation Notes:" do
  it "div-cblocks edited - OIR:loose" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %div#id1
     %div#a cblock1
     %div#b
            cblock3
      %p cblock4
HAML
      wspc.html.should == <<'HTML'
<div>
  <div id='id1'>
    <div id='a'>cblock1</div>
    <div id='b'>
      cblock3
      <p>cblock4</p>
    </div>
  </div>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Indentation -06- Implementation Notes:" do
  it "div-cblocks edited with div#id2 Offside - OIR:loose" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %div#id1
     %div#a cblock1
     %div#b
            cblock3
      %p cblock4
     %div#id2
HAML
      wspc.html.should == <<'HTML'
<div>
  <div id='id1'>
    <div id='a'>cblock1</div>
    <div id='b'>
      cblock3
      <p>cblock4</p>
    </div>
    <div id='id2'></div>
  </div>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Indentation -07- Implementation Notes:" do
  it "Haml for Canonical Html " do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%html
  %head
  %body
    CONTENT
HAML
      wspc.html.should == <<'HTML'
<html>
  <head></head>
  <body>
    CONTENT
  </body>
</html>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Normalizing -01- Implementation Notes:" do
  it "Normalizing HtmlOutput Whitespace and Indentation" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.flow
  %p Inline content
     Nested content
HAML
      wspc.html.should == <<'HTML'
<div class='flow'>
  <p>Inline content
    Nested content
  </p>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Normalizing -02- Implementation Notes:" do
  it "Normalizing -- Tag with Mixed Content from Multiline Content Block" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%div
  %p
    First line  |
    Second line |
HAML
      wspc.html.should == <<'HTML'
<div>
  <p>First line Second line</p>
</div>
HTML
    end
  end
end
#Legacy Haml:
#<div>\n  <p>\n    First line  Second line \n  </p>\n</div>


#================================================================
describe HamlRender, "Normalizing -03- Implementation Notes:" do
  it "Normalizing -- foo bar - Legacy Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "foo bar"
  %p= strvar
  - strvar = "foo\nbar"
  %p= strvar
  - strvar = "foo\nbar"
  %p eggs #{strvar} spam
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <p>foo bar</p>
  <p>
    foo
    bar
  </p>
  <p>
    eggs foo
    bar spam
  </p>
</div>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Normalizing -04- Implementation Notes:" do
  it "Normalizing -- foo bar - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "foobar"
  %p
    = strvar
  - strvar = "foo\nbar"
  %p
    = strvar
  - strvar = "foo\nbar"
  %p= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <p>
    foobar
  </p>
  <p>
    foo
    bar
  </p>
  <p>foo
    bar
  </p>
</div>
HTML
    end
  end
end
#Legacy Haml:
#<div class='quux'>
#  <p>\n    foobar\n  </p>
#  <p>\n    foo\n    bar\n  </p>
#  <p>\n    foo\n    bar\n  </p>
#</div>


#================================================================
describe HamlRender, "Normalizing -05- Implementation Notes:" do
  it "Normalizing -- foo bar - Interpolated Initial Whitespace - Legacy Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "  foo\n   bar"
  %p= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <p>
      foo
       bar
  </p>
</div>
HTML
    #end
  end
end
#WSE Haml
#<div class='quux'>\n  <p>  foo\n       bar\n  </p>\n</div>


#================================================================
describe HamlRender, "Normalizing -06- Implementation Notes:" do
  it "Normalizing -- foo bar - Interpolated Initial Whitespace - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "  foo\n   bar"
  %p= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <p>  foo
       bar
  </p>
</div>
HTML
    end
  end
end
#Legacy:
#<div class='quux'>\n  <p>\n      foo\n       bar\n  </p>\n</div>


#================================================================
describe HamlRender, "Normalizing -07- Implementation Notes:" do
  it "Normalizing -- Initial Whitespace - Preserve Tag - Not Preserved - Legacy Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "   foo\n   bar"
  %code= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <code>foo&#x000A;   bar</code>
</div>
HTML
    #end
  end
end
#WSE Haml:
#<div class='quux'>
#  <code>   foo&#x000A;   bar</code>
#</div>


#================================================================
describe HamlRender, "Normalizing -08- Implementation Notes:" do
  it "Normalizing -- Initial Whitespace - Preserve Tag - Preserved - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "   foo\n   bar"
  %code= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <code>   foo&#x000A;   bar</code>
</div>
HTML
    end
  end
end
#Legacy:
#<div class='quux'>
#  <code>foo&#x000A;   bar</code>
#</div>


#================================================================
describe HamlRender, "Normalizing -09- Implementation Notes:" do
  it "Normalizing -- Html Endtag - Preserve Tag - Preserved - Legacy Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "   foo\n   bar  \n\n"
  %code= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <code>foo&#x000A;   bar</code>
</div>
HTML
    #end
  end
end
#WSE Haml
#<div class='quux'>
#  <code>   foo&#x000A;   bar  &#x000A;</code>
#</div>


#================================================================
describe HamlRender, "Normalizing -10- Implementation Notes:" do
  it "Normalizing -- Html Endtag - Preserve Tag - Preserved - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "   foo\n   bar  \n\n"
  %code= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <code>   foo&#x000A;   bar  &#x000A;</code>
</div>
HTML
    end
  end
end
#<div class='quux'>
#  <code>foo&#x000A;   bar</code>
#</div>


#================================================================
describe HamlRender, "Normalizing -11- Implementation Notes:" do
  it "Normalizing -- InitialWhitespace Plaintext - Preserve Tag - Preserved - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  %code   Foobar  
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <code>  Foobar  </code>
</div>
HTML
    end
  end
end
#Legacy:
#<div class='quux'>\n  <code>Foobar</code>\n</div>


#================================================================
describe HamlRender, "Normalizing -12- Implementation Notes:" do
  it "Normalizing -- Mixed Content Leading Whitespace in Expression - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
  - strvar = "   foo\n     bar  \n"
  %code= strvar
  %cope= strvar
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <code>   foo&#x000A;     bar  \n</code>
  <cope> 
    foo
    bar
  </cope>
</div>
HTML
    end
  end
end
#Notice: For WSE Haml, with non-option:preserve tag <cope>:
#  Under oir:loose or oir:strict
#  Only 1 OutputIndentStep (defaulted at 2)
#Legacy:
#<div class='quux'>
#  <code>foo&#x000A;     bar</code>
#  <cope>\n       foo\n         bar\n  </cope>
#</div>


#================================================================
describe HamlRender, "Whitelines -01- Implementation Notes:" do
  it "Normalizing -- Whitelines - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
    %div
      %p cblock1
      %p

         cblock2a      

      
         cblock2b      

         cblock2c


      %p cblock3

      %p cblock4inline
         cblock4a
          -#             # Inserted into Nested Content -- a Haml Comment
           cblock4c      # Captured by Haml COmment as Nested Content ContentBlock

           cblock4d
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <div>
    <p>cblock1</p>
    <p>
      cblock2a

      cblock2b
      cblock2c
    </p>

    <p>cblock3</p>

    <p>
      cblock4inline
      cblock4a
      cblock4d
    </p>
  </div>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Whitelines -02- Implementation Notes:" do
  it "Normalizing -- Whitelines - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.quux
    %div
      %p cblock1
      %p

         cblock2a      

      
         cblock2b      

         cblock2c


      %p cblock3

      %p cblock4inline
         cblock4a
          -#             # Inserted into Nested Content -- a Haml Comment
           cblock4c      # Captured by Haml COmment as Nested Content ContentBlock

           cblock4d
HAML
      wspc.html.should == <<'HTML'
<div class='quux'>
  <div>
    <p>cblock1</p>
    <p>
      cblock2a

      cblock2b
      cblock2c
    </p>

    <p>cblock3</p>

    <p>
      cblock4inline
      cblock4a
      cblock4d
    </p>
  </div>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Heads - HamlComment -01- Implementation Notes:" do
  it "Haml Comment - Lexeme" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
.zork
  %p para1
  -# Haml Comment Inline
  %p para2
.gork
  %p para1
  -#
     WSE Haml Comment Nested
  %p para2
HAML
      wspc.html.should == <<'HTML'
<div class='zork'>
  <p>para1</p>
  <p>para2</p>
</div>
<div class='gork'>
  <p>para1</p>
  <p>para2</p>
</div>
HTML
    end
  end
end
#Notice: "Pending WSE" because the Comment designated as 
# "WSE Haml Comment..." would, in legacy Haml have to be 
# indented one (document-wide fixed) IndentStep from 
# the '-' in '-#' ... typically two spaces, and could not
# be aligned as shown (or easily inserted above text an
# author wants to make transparent).


#================================================================
describe HamlRender, "Heads - HamlComment -02- Implementation Notes:" do
  it "Haml Comment - Lexeme" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
.zork
  %p para1
  -# Text comment
  %p para2
.bork
  %p para1
  -#Text comment
  %p para2
HAML
      wspc.html.should == <<'HTML'
<div class='zork'>
  <p>para1</p>
  <p>para2</p>
</div>
<div class='bork'>
  <p>para1</p>
  <p>para2</p>
</div>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Heads - HamlComment -03- Implementation Notes:" do
  it "Haml Comment - Structure - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.tutu
    %esku
      %skulist
        %scat Lights
                   %sid 20301
                 %sname Spot2
                %sdescr Follow spotlight
        %scat Sound
                   %sid 20304
                 %sname Amplifier
                %sdescr 60watt reverb
HAML
      wspc.html.should == <<'HTML'
<div class='tutu'>
  <esku>
    <skulist>
      <scat>Lights
        <sid>20301</sid>
        <sname>Spot2</sname>
        <sdescr>Follow spotlight</sdescr>
      <scat>Sound
        <sid>20304</sid>
        <sname>Amplifier</sname>
        <sdescr>60watt reverb</sdescr>
      </scat>
    </skulist>
  </esku>
</div>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Heads - HamlComment -04- Implementation Notes:" do
  it "Haml Comment - Structure: Haml Comment Mixed Content - Problematic - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.tutu
    %esku
      %skulist
        %scat Lights
                   %sid 20301
               -#%sname Spot2
                 %sname Spot3
                %sdescr Follow spotlight
        %scat Sound
                   %sid 20304
                 %sname Amplifier
                %sdescr 60watt reverb
HAML
      wspc.html.should == <<'HTML'
<div class='tutu'>
  <esku>
    <skulist>
      <scat>Lights
        <sid>20301</sid>
        <sname>Spot3</sname>
        <sdescr>Follow spotlight</sdescr>
      <scat>Sound
        <sid>20304</sid>
        <sname>Amplifier</sname>
        <sdescr>60watt reverb</sdescr>
      </scat>
    </skulist>
  </esku>
</div>
HTML
    end
  end
end
#WSE Haml: We'd prefer this, where Haml Comment
# is _either_ Inline _or_ Nested,  but WSE Haml can't go that far, probably.
# So instead both of the snames and the sdescr are scooped up into the 
# HamlComment. Solution is similar to what authors must do under 
# Legacy Haml ... see next RSpec.


#================================================================
describe HamlRender, "Heads - HamlComment -05- Implementation Notes:" do
  it "Haml Comment - Structure: Haml Comment Mixed Content - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.tutu
    %esku
      %skulist
        %scat Lights
                   %sid 20301
               -#%sname Spot2    # Haml Comment Inline w/Whiteline break

                 %sname Spot3
                %sdescr Follow spotlight
        %scat Sound
                   %sid 20304
                 %sname Amplifier
                %sdescr 60watt reverb
HAML
      wspc.html.should == <<'HTML'
<div class='tutu'>
  <esku>
    <skulist>
      <scat>Lights
        <sid>20301</sid>
        <sname>Spot3</sname>
        <sdescr>Follow spotlight</sdescr>
      <scat>Sound
        <sid>20304</sid>
        <sname>Amplifier</sname>
        <sdescr>60watt reverb</sdescr>
      </scat>
    </skulist>
  </esku>
</div>
HTML
    end
  end
end
#WSE Haml: Simplified alt to problematic Haml Comment content block model


#================================================================
describe HamlRender, "Heads - HtmlComment -01- Implementation Notes:" do
  it "Html Comment - Producing well-formed Html - nested comment - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.zork
  %p para1
  / plaintext html comment
  %p para2
  / 
    nested commenting line1 
    / nested commenting line2
  %p para3
HAML
      wspc.html.should == <<'HTML'
<div class='zork'>
  <p>para1</p>
  <!-- plaintext html comment -->
  <p>para2</p>
  <!--
    nested commenting line1
    / nested commenting line2
  <p>para3</p>
</div>
HTML
    end
  end
end
#Legacy Haml:
#<div class='zork'>
#  <p>para1</p>
#  <!-- plaintext html comment -->
#  <p>para2</p>
#  <!--
#    nested commenting line1
#    <!-- nested commenting line2 -->
#  -->
#  <p>para3</p>
#</div>


#================================================================
describe HamlRender, "Heads - HtmlComment -02- Implementation Notes:" do
  it "Html Comment - Producing well-formed Html - improper content - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
.zork
  %p para1
  / plaintext html comment
  %p para2
  / comment with embedded --> html comment endtag
  <p>para3</p>
  / comment with embedded <!-- html comment starttag
  <p>para4</p>
  / comment with embedded --- serial hyphens
HAML
      wspc.html.should == <<'HTML'
<div class='zork'>
  <p>para1</p>
  <!-- plaintext html comment -->
  <p>para2</p>
  <!-- comment with embedded --><!-- html comment endtag -->
  <p>para3</p>
  <!-- comment with embedded --><!-- html comment starttag -->
  <p>para4</p>
  <!-- comment with embedded -   serial hyphens -->
</div>
HTML
    end
  end
end
#Legacy Haml:
#<div class='zork'>
#  <p>para1</p>
#  <!-- plaintext html comment -->
#  <p>para2</p>
#  <!-- comment with embedded --> html comment endtag -->
#  <p>para3</p>
#  <!-- comment with embedded <!-- html comment starttag -->
#  <p>para4</p>
#  <!-- comment with embedded --- serial hyphens -->
#</div>
#WSE Haml: produce well-formed Html
#
#    Within Haml Comment ContentBlock (WSE Haml)
#    HamlSource                 WSE Haml HtmlOutput
#    (After Interpolation)
#    ---------------------      -------------------
#    /--+>/                     --><!--
#    /<!--+/                    --><!--
#    /-(-+)/                    '-' + ' ' * $1.length 


#================================================================
describe HamlRender, "Heads - HereDoc -01- Implementation Notes:" do
  it "HereDoc - Base Case - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts, 'var1' => 'variable1' )
%body
  %dir
    %dir
      %p<<DOC
     HereDoc
-# #{var1}
DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir>
      <p>
     HereDoc 
-# variable1
      </p>
    </dir>
  </dir>
</body>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Heads - HereDoc -02- Implementation Notes:" do
  it "HereDoc - Term Indentation Case - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts, 'var1' => 'variable1' )
%body
  %dir
    %dir
      %p<<-DOC
     HereDoc
-# #{var1}
      DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir>
      <p>
     HereDoc 
-# variable1
      </p>
    </dir>
  </dir>
</body>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Heads - HereDoc -03- Implementation Notes:" do
  it "HereDoc - Case:Attributes first - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%body
  %dir
    %dir
      %p{ :a => 'b',
          :y => 'z' }<<-DOC
     HereDoc Para
     DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir>
      <p a='b' y='z'>
     HereDoc Para
      </p>
    </dir>
  </dir>
</body>
HTML
    end
  end
end


#================================================================
describe HamlRender, "Heads - HereDoc -04- Implementation Notes:" do
  it "HereDoc - Case:trim_out - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%body
  %dir
    %dir
      %p><<-DOC
     HereDoc Para
     DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir><p>
     HereDoc Para
    </p></dir>
  </dir>
</body>
HTML
    end
  end
end
#Notice: Also contains WSE adjustment for trim_out alignment of endtags


#================================================================
describe HamlRender, "Heads - HereDoc -05- Implementation Notes:" do
  it "HereDoc - Case: Textline Following HereDoc Term - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%body
  %dir
    %dir
      %p#n1<<-DOC
     HereDoc Para
     DOC
        %p#n2 para2
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir>
      <p id='n1'>
     HereDoc Para
      </p>
      <p id='n2'>para2</p>
    </dir>
  </dir>
</body>
HTML
    end
  end
end
#WSE Haml: tag "%p#n2" must be a sibling to "%p#n1" because
#  the latter's tag contentblock is already closed ...  so
#  "%p#n2" cannot append to that tree. Provided it satisfies
#  the applicable OIR, then "%p#n2" must be a sibling.
#  The reference is the "%p#n1" Head, not the "DOC" delimiter.


#================================================================
describe HamlRender, "Heads - HereDoc -06- Implementation Notes:" do
  it "HereDoc - Case: Textline Following HereDoc Term - Undented - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%body
  %dir
    %dir#d1
      %p#n1<<-DOC
     HereDoc Para
  DOC
    %p#n2 para2
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir id='d1'>
      <p id='n1'>
     HereDoc Para
      </p>
    </dir>
    <p id='n2'>para2</p>
  </dir>
</body>
HTML
    end
  end
end
#WSE Haml: tag "%p#n2" is a sibling to "%dir#d1"
#  The reference is the "%p#n1" Head, not the "DOC" delimiter.


#================================================================
describe HamlRender, "Heads - HereDoc -07- Implementation Notes:" do
  it "HereDoc - Case: Exceptions - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      lambda { wspc.render_haml( <<'HAML', h_opts ) }.should raise_error(Haml::SyntaxError,/Self-closing tag.*content/)
%body
  %dir
    %dir
      %img<<DOC
      HereDoc
      DOC
HAML
      wspc.html.should == nil
    end
  end
end


#================================================================
describe HamlRender, "Heads - HereDoc -08- Implementation Notes:" do
  it "HereDoc - Case: Exceptions - WSE Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      lambda { wspc.render_haml( <<'HAML', h_opts ) }.should raise_error(Haml::SyntaxError,/Self-closing tag.*content/)
%body
  %dir
    %dir
      %sku/<<DOC
      HereDoc
      DOC
HAML
      wspc.html.should == nil
    #end
  end
end


#================================================================
describe HamlRender, "Heads - HereDoc -09- Implementation Notes:" do
  it "HereDoc - TODO: Possible content following term spec, example 1 - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%body
  %dir
    %dir
      %span.red<<-DOC.
     HereDoc Para
     DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir>
      <span class='red'>
     HereDoc Para
      </span>.
    </dir>
  </dir>
</body>
HTML
    end
  end
end
#TODO: Possible capability, but not included in WSE.


#================================================================
describe HamlRender, "Heads - HereDoc -10- Implementation Notes:" do
  it "HereDoc - TODO: Possible content following term spec - Example 2 - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%body
  %dir
    %p *
      %span.ital<<-DOC *
                 HereDoc Para 
           DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <p>*
      <span class='ital'>
                 HereDoc Para 
      </span> *
    </p>
  </dir>
</body>
HTML
    end
  end
end
#TODO: Possible capability, but not included in WSE.


#================================================================
describe HamlRender, "Heads - HereDoc -11- Implementation Notes:" do
  it "HereDoc - TODO: Possible content following term spec - example 3 - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts, :punct => "..." )
%body
  %dir
    %dir
      %span <<-DOC#{punct}
HereDoc Para
               DOC
HAML
      wspc.html.should == <<'HTML'
<body>
  <dir>
    <dir>
      <span>
HereDoc Para
      </span>...
    </dir>
  </dir>
</body>
HTML
    end
  end
end
#TODO: Possible capability, but not included in WSE.


#================================================================
describe HamlRender, "Heads - Preserve -01- Implementation Notes:" do
  it "Preserve starttag-endtag mechanics - WSE Haml" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code', 'ptag'],
                 :preformatted => ['ver', 'vtag'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts, :strvar => "toto\ntutu" )
.wspcpre
  %snap
    %ptag= "Bar\nBaz"
  %crak
    %ptag #{strvar}
  %pahp
    %ptag
      :preserve
          def fact(n)  
            (1..n).reduce(1, :*)  
          end  
HAML
      wspc.html.should == <<'HTML'
<div class='wspcpre'>
  <snap>
    <ptag>Bar&#x000A;Baz</ptag>
  </snap>
  <crak>
    <ptag>toto&#x000A;tutu</ptag>
  </crak>
  <pahp>
    <ptag>  def fact(n)  &#x000A;    (1..n).reduce(1, :*)  &#x000A;  end</ptag>
  </pahp>
</div>
HTML
    #end
  end
end
#Notice: The OutputIndent for filter:preserve is 2 spaces, the
# difference after the IndentStep is removed. If this were legacy Haml
# the file-global IndentStep would be 2-spaces, leaving 2 spaces.


#================================================================
describe HamlRender, "Heads - Preserve -02- Implementation Notes:" do
  it "Preformatted starttag-endtag mechanics - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code', 'ptag'],
                 :preformatted => ['ver', 'vtag'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts, :strvar => "toto\ntutu" )
.wspcpre
  %snap
    %vtag= "Bar\nBaz"
  %crak
    %vtag #{strvar}
  %pahp
    %vtag
      :preformatted
          def fact(n)  
            (1..n).reduce(1, :*)  
          end  
    %vtag<<ASCII
o           .'`/
    '      /  (
  O    .-'` ` `'-._      .')
     _/ (o)        '.  .' /
     )       )))     ><  <
     `\  |_\      _.'  '. \
       `-._  _ .-'       `.)
   jgs     `\__\
ASCII
HAML
      wspc.html.should == <<'HTML'
<div class='wspcpre'>
  <snap>
    <vtag>
Bar
Baz
    </vtag>
  </snap>
  <crak>
    <vtag>
toto
tutu
    </vtag>
  </crak>
  <pahp>
    <vtag>
      def fact(n)  
        (1..n).reduce(1, :*)  
      end  
    </vtag>
  </pahp>
  <vtag>
o           .'`/
    '      /  (
  O    .-'` ` `'-._      .')
     _/ (o)        '.  .' /
     )       )))     ><  <
     `\  |_\      _.'  '. \
       `-._  _ .-'       `.)
   jgs     `\__\
  </vtag>
</div>
HTML
    end
  end
end
#Notice: WSE filter:preformatted delivers a ContentBlock with the BLM of
# its ContentBlock aligned with the indentation of the 
# :preformatted Head.


#================================================================
describe HamlRender, "Heads - find_and_preserve -01- Implementation Notes:" do
  it "FAP - Basic examples" do
    #pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%zot
  = find_and_preserve("Foo\n<pre>Bar\nBaz</pre>")
  = find_and_preserve("Foo\n%Bar\nBaz")
  = find_and_preserve("Foo\n<xre>Bar\nBaz</xre>")
HAML
      wspc.html.should == <<"HTML"
<zot>
  Foo\n  <pre>Bar&#x000A;Baz</pre>
  Foo\n  %Bar\n  Baz
  Foo\n  <xre>Bar\n    Baz</xre>
</zot>
HTML
    #end
  end
end


#================================================================
describe HamlRender, "Heads - find_and_preserve -02- Implementation Notes:" do
  it "FAP - Basic examples - html_escape:true" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => true, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%zot
  = find_and_preserve("Foo\n<pre>Bar\nBaz</pre>")
  = find_and_preserve("Foo\n%Bar\nBaz")
  = find_and_preserve("Foo\n<xre>Bar\nBaz</xre>")
HAML
      wspc.html.should == <<"HTML"
<zot>
  Foo\n  &lt;pre&gt;Bar&#x000A;Baz&lt;/pre&gt;
  Foo\n  %Bar\n  Baz
  Foo\n  &lt;xre&gt;Bar\n    Baz&lt;/xre&gt;
</zot>
HTML
    end
  end
end
#Legacy Haml:
#<zot>
#  Foo\n  &lt;pre&gt;Bar&amp;#x000A;Baz&lt;/pre&gt;
#  Foo\n  %Bar\n  Baz
#  Foo\n  &lt;xre&gt;Bar\n  Baz&lt;/xre&gt;
#</zot>


#================================================================
describe HamlRender, "Heads - Tilde -01- Implementation Notes:" do
  it "FAP & Tilde - Basic examples - html_escape:true - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => true, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'loose' }
      wspc.render_haml( <<'HAML', h_opts )
%zot
  = find_and_preserve("Foo\n<pre>Bar\nBaz</pre>")
  ~ "Foo\n<pre>Bar\nBaz</pre>"
HAML
      wspc.html.should == <<"HTML"
<zot>
  Foo\n  &lt;pre&gt;Bar&#x000A;Baz&lt;/pre&gt;
  Foo\n  &lt;pre&gt;Bar&#x000A;Baz&lt;/pre&gt;
</zot>
HTML
    end
  end
end
#Legacy:
#<zot>
#  Foo\n  &lt;pre&gt;Bar&amp;#x000A;Baz&lt;/pre&gt;
#  Foo\n  &lt;pre&gt;Bar\n  Baz&lt;/pre&gt;
#</zot>


#================================================================
describe HamlRender, "Heads - Whitespace Removal -01- Implementation Notes:" do
  it "Simple WSE Haml Mixed Content" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => false, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%bac
  %p Foo
    Bar
    Baz
%saus
  %p= "Thud\nGrunt\nGorp  "
HAML
      wspc.html.should == <<HTML
<bac>
  <p>Foo
    Bar
    Baz
  </p>
</bac>
<saus>
  <p>Thud
    Grunt
    Gorp
  </p>
</saus>
HTML
    end
  end
end
# Removing the Inline Content from the Mixed Content block (WSE Haml-required)
# Legacy gives the following alignments:
# <p>
#   Bar
#   Baz
# </p>
#
# <p>
#   Thud
#   Grunt
#   Gorp
# </p>


#================================================================
describe HamlRender, "Heads - Whitespace Removal -02- Implementation Notes:" do
  it "Whitespace removal - Trim_in - WSE Haml" do
    pending "WSE" do
      wspc = HamlRender.new
      h_opts = { :escape_html => true, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%eggs
  %div
    %p< Foo
      Bar
      Baz
  %p para1
%spam
  %div
    %p<= "  Foo\nBar\nBaz  "
  %p para2
HAML
      wspc.html.should == <<HTML
<eggs>
  <div>
    <p>Foo
      Bar
      Baz</p>
  </div>
  <p>para1</p>
</eggs>
<spam>
  <div>
    <p>  Foo
    Bar
    Baz  </p>
  </div>
  <p>para2</p>
</spam>
HTML
    end
  end
end

#================================================================
describe HamlRender, "Heads - Whitespace Removal -03- Implementation Notes:" do
  it "Trim_out Alignment - WSE Haml" do
    pending "BUG" do
      wspc = HamlRender.new
      h_opts = { :escape_html => true, 
                 :preserve => ['pre', 'textarea', 'code'],
                 :preformatted => ['ver'],
                 :oir => 'strict' }
      wspc.render_haml( <<'HAML', h_opts )
%p
  %out
    %div>
      %in
        Foo!
HAML
      wspc.html.should == <<HTML
<p>
  <out><div>
      <in>
        Foo!
      </in>
  </div></out>
</p>
HTML
    end
  end
end
#Legacy:
#  <out><div>
#      <in>
#        Foo!
#      </in>
#    </div></out>

