use strict;
use Test::Base;
use HTML::Selector::XPath;

plan tests => 1 * blocks;
filters { selector => 'chomp', xpath => 'chomp' };

run {
    my $block = shift;
    my $selector = HTML::Selector::XPath->new($block->selector);
    is $selector->to_xpath, $block->xpath, $block->selector;
}

__END__
===
--- selector
*
--- xpath
//*

===
--- selector
E
--- xpath
//E

===
--- selector
E F
--- xpath
//E//F

===
--- selector
E > F
--- xpath
//E/F

===
--- selector
p.pastoral.marine
--- xpath
//p[contains(concat(' ', @class, ' '), ' pastoral ')][contains(concat(' ', @class, ' '), ' marine ')]

===
--- selector
E:first-child
--- xpath
//*[1]/self::E

===
--- selector
F E:first-child
--- xpath
//F//*[1]/self::E

===
--- selector
F > E:first-child
--- xpath
//F/*[1]/self::E

===
--- selector
E:lang(c)
--- xpath
//E[@xml:lang='c' or starts-with(@xml:lang, 'c-')]

===
--- selector
E + F
--- xpath
//E/following-sibling::*[1]/self::F

===
--- selector
E + #bar
--- xpath
//E/following-sibling::*[1]/self::*[@id='bar']

===
--- selector
E + .bar
--- xpath
//E/following-sibling::*[1]/self::*[contains(concat(' ', @class, ' '), ' bar ')]

===
--- selector
E[foo]
--- xpath
//E[@foo]

===
--- selector
E[foo="warning"]
--- xpath
//E[@foo='warning']

===
--- selector
E[foo~="warning"]
--- xpath
//E[contains(concat(' ', @foo, ' '), ' warning ')]

===
--- selector
E[foo^="warning"]
--- xpath
//E[starts-with(@foo,'warning')]

===
--- selector
E:not([foo^="warning"])
--- xpath
//E[not(starts-with(@foo,'warning'))]

===
--- selector
E[foo$="warning"]
--- xpath
//E[ends-with(@foo,'warning')]

===
--- selector
E[lang|="en"]
--- xpath
//E[@lang='en' or starts-with(@lang, 'en-')]

===
--- selector
DIV.warning
--- xpath
//DIV[contains(concat(' ', @class, ' '), ' warning ')]

===
--- selector
E#myid
--- xpath
//E[@id='myid']

===
--- selector
foo.bar, bar
--- xpath
//foo[contains(concat(' ', @class, ' '), ' bar ')] | //bar

===
--- selector
E:nth-child(1)
--- xpath
//E[count(preceding-sibling::*) = 0]

===
--- selector
E:last-child
--- xpath
//E[not(following-sibling::*)]


===
--- selector
F E:last-child
--- xpath
//F//E[not(following-sibling::*)]

===
--- selector
F > E:last-child
--- xpath
//F/E[not(following-sibling::*)]

===
--- selector
E[@href*="bar"]
--- xpath
//E[contains(@href, 'bar')]

===
--- selector
E:not([@href*="bar"])
--- xpath
//E[not(contains(@href, 'bar'))]

===
--- selector
F > E:nth-of-type(3)
--- xpath
//F/E[3]

===
--- selector
E ~ F
--- xpath
//E/following-sibling::F

===
--- selector
E ~ F.foo
--- xpath
//E/following-sibling::F[contains(concat(' ', @class, ' '), ' foo ')]

===
--- selector
E:contains("Hello")
--- xpath
//E[text()[contains(string(.),"Hello")]]

===
--- selector
E:contains( "Hello" )
--- xpath
//E[text()[contains(string(.),"Hello")]]
===
--- selector
E ~ F
--- xpath
//E/following-sibling::F

===
--- selector
E ~ #bar
--- xpath
//E/following-sibling::*[@id='bar']

===
--- selector
E ~ .bar
--- xpath
//E/following-sibling::*[contains(concat(' ', @class, ' '), ' bar ')]

===
--- selector
E ~ *
--- xpath
//E/following-sibling::*

===
--- selector
.foo ~ E
--- xpath
//*[contains(concat(' ', @class, ' '), ' foo ')]/following-sibling::E

===
--- selector
.foo ~ *
--- xpath
//*[contains(concat(' ', @class, ' '), ' foo ')]/following-sibling::*

===
--- selector
.foo ~ .bar
--- xpath
//*[contains(concat(' ', @class, ' '), ' foo ')]/following-sibling::*[contains(concat(' ', @class, ' '), ' bar ')]

===
--- selector
> em
--- xpath
//*/em

===
--- selector
:first-child
--- xpath
//*[1]/self::*

===
--- selector
E.c:first-child
--- xpath
//*[1]/self::E[contains(concat(' ', @class, ' '), ' c ')]

===
--- selector
E:first-child.c
--- xpath
//*[1]/self::E[contains(concat(' ', @class, ' '), ' c ')]

===
--- selector
E#i:first-child
--- xpath
//*[1]/self::E[@id='i']

===
--- selector
E:first-child#i
--- xpath
//*[1]/self::E[@id='i']

===
--- selector
:lang(c)
--- xpath
//*[@xml:lang='c' or starts-with(@xml:lang, 'c-')]

===
--- selector
:lang(c)#i
--- xpath
//*[@xml:lang='c' or starts-with(@xml:lang, 'c-')][@id='i']

===
--- selector
#i:lang(c)
--- xpath
//*[@id='i'][@xml:lang='c' or starts-with(@xml:lang, 'c-')]

===
--- selector
*:lang(c)#i
--- xpath
//*[@xml:lang='c' or starts-with(@xml:lang, 'c-')][@id='i']

===
--- selector
E:lang(c)#i
--- xpath
//E[@xml:lang='c' or starts-with(@xml:lang, 'c-')][@id='i']

===
--- selector
E#i:lang(c)
--- xpath
//E[@id='i'][@xml:lang='c' or starts-with(@xml:lang, 'c-')]

===
--- selector
*:lang(c)#i:first-child
--- xpath
//*[1]/self::*[@xml:lang='c' or starts-with(@xml:lang, 'c-')][@id='i']

===
--- selector
E:lang(c)#i:first-child
--- xpath
//*[1]/self::E[@xml:lang='c' or starts-with(@xml:lang, 'c-')][@id='i']

===
--- selector
E:lang(c):first-child#i
--- xpath
//*[1]/self::E[@xml:lang='c' or starts-with(@xml:lang, 'c-')][@id='i']

===
--- selector
E#i:lang(c):first-child
--- xpath
//*[1]/self::E[@id='i'][@xml:lang='c' or starts-with(@xml:lang, 'c-')]

===
--- selector
#bar
--- xpath
//*[@id='bar']

===
--- selector
*#bar
--- xpath
//*[@id='bar']

===
--- selector
*[foo]
--- xpath
//*[@foo]

===
--- selector
[foo]
--- xpath
//*[@foo]


===
--- selector
.warning
--- xpath
//*[contains(concat(' ', @class, ' '), ' warning ')]

===
--- selector
*.warning
--- xpath
//*[contains(concat(' ', @class, ' '), ' warning ')]

 
===
--- selector
:nth-child(1)
--- xpath
//*[count(preceding-sibling::*) = 0]

===
--- selector
*:nth-child(1)
--- xpath
//*[count(preceding-sibling::*) = 0]

===
--- selector
E:nth-child(1)
--- xpath
//E[count(preceding-sibling::*) = 0]

===
--- selector
E:nth-child(2)
--- xpath
//E[count(preceding-sibling::*) = 1]

===
--- selector
:root
--- xpath
/*

===
--- selector
E:root
--- xpath
/E

===
--- selector
E:empty
--- xpath
//E[not(* or text())]
===
--- selector
:empty
--- xpath
//*[not(* or text())]

===
--- selector
p , :root
--- xpath
//p | /*

===
--- selector
p , q
--- xpath
//p | //q
===
--- selector
div *:not(p) em
--- xpath
//div//*[not(self::p)]//em
