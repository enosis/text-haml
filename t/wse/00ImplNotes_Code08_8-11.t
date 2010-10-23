#!/usr/bin/env perl
#
#00ImplNotes_Code08_8-11.t
#./text-haml/t/wse
#
#Calling:  ./wse $ make code_8
#       :  ./wse $ make code_8_8
#          ./wse $ perl 00ImplNotes_Code08_8-11.t
#
#Authors:
# enosis@github.com Nick Ragouzis - Last: Oct2010
#
#Correspondence:
# Haml_WhitespaceSemanticsExtension_ImplmentationNotes v0.5, 20101020
#

#Notice: With Whitespace Semantics Extension (WSE), OIR:loose is the default
#Notice: Trailing whitespace is present on some Textlines

use strict;
use warnings;

use Test::More tests=>2;
use Test::Exception;

BEGIN {
  use lib qw(../../lib);
  use_ok( 'Text::Haml' ) or die;
}

my ($haml,$tname,$htmloutput);


TODO: {   #<<<<<
  local $TODO = " -- WSE Haml unimplemented";
#================================================================
$tname = "ImplNotes Code 8.8-11 - Normalizing - InitialWhitespace Plaintext, Preserve Tag, Preserved - WSE Haml";
$haml = Text::Haml->new( escape_html => 0,
                         preserve => ['pre', 'textarea', 'code'],
                         preformatted => ['ver'],
                         oir => 'loose' );
$htmloutput = $haml->render(<<'HAML');
.quux
  %code   Foobar  
HAML
is($htmloutput, <<'HTML', $tname);
<div class='quux'>
  <code>  Foobar  </code>
</div>
HTML
#Legacy:
#<div class='quux'>\n  <code>Foobar</code>\n</div>
}#TODO>>>>>

