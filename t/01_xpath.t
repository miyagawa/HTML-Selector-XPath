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

