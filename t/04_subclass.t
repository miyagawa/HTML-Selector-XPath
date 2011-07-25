package HTML::Selector::XPath::Extended;

use strict;
use Test::Base;

use base qw(HTML::Selector::XPath);

plan tests => 1 * blocks;
filters { selector => 'chomp', xpath => 'chomp' };

sub parse_pseudo {
    my ($self, $pseudo, $expr) = @_;
    return q{[@type='foo']} if $pseudo eq 'foo';
    return "" if $pseudo eq 'bar';
}

run {
    my $block = shift;
    my $selector = HTML::Selector::XPath::Extended->new($block->selector);
    is $selector->to_xpath, $block->xpath, $block->selector;
}

__END__
===
--- selector
:foo
--- xpath
//*[@type='foo']

===
--- selector
:bar
--- xpath
//*
