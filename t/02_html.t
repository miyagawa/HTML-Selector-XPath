use strict;
use Test::Base;
use HTML::Selector::XPath;

eval { require HTML::TreeBuilder::XPath };
plan skip_all => "HTML::TreeBuilder::XPath is not installed." if $@;

filters { selector => 'chomp', expected => [ 'lines', 'array' ] };
plan tests => 1 * blocks;

run {
    my $block = shift;
    my $tree = HTML::TreeBuilder::XPath->new;
    $tree->parse($block->input);
    $tree->eof;

    my @nodes = $tree->findnodes( HTML::Selector::XPath->new($block->selector)->to_xpath );
    is_deeply [ map $_->as_XML, @nodes ], $block->expected, $block->selector;
}

__END__

===
--- input
<body>
<div class="foo">foo</div>
<div class="bar">foo</div>
</body>
--- selector
div.foo
--- expected
<div class="foo">foo</div>

===
--- input
<ul>
<li><a href="foo.html">bar</a></li>
<li><a href="foo.html">baz</a></li>
</ul>
--- selector
ul li
--- expected
<li><a href="foo.html">bar</a></li>
<li><a href="foo.html">baz</a></li>

===
--- input
<ul>
<li><a href="foo.html">bar</a></li>
<li><a href="foo.html">baz</a></li>
</ul>
--- selector
ul li:first-child
--- expected
<li><a href="foo.html">bar</a></li>

===
--- input
<ul>
<li><a href="foo.html">bar</a></li>
<li class="bar baz"><a href="foo.html">baz</a></li>
<li class="bar"><a href="foo.html">baz</a></li>
</ul>
--- selector
li.bar
--- expected
<li class="bar baz"><a href="foo.html">baz</a></li>
<li class="bar"><a href="foo.html">baz</a></li>

===
--- input
<div>foo</div>
<div id="bar">baz</div>
--- selector
div#bar
--- expected
<div id="bar">baz</div>

===
--- input
<div>foo</div>
<div id="bar">baz</div>
<div class="baz">baz</div>
--- selector
div#bar, div.baz
--- expected
<div id="bar">baz</div>
<div class="baz">baz</div>

===
--- input
<div>foo</div>
<div lang="en">baz</div>
<div lang="en-us">baz</div>
--- selector
div:not([lang|="en"])
--- expected
<div>foo</div>

===
--- input
<div>foo</div>
<div class="foo">baz</div>
<div class="foob">baz</div>
--- selector
div:not([class~="foo"])
--- expected
<div>foo</div>
<div class="foob">baz</div>

===
--- input
<div>foo</div>
<div class="foo">baz</div>
<div class="foob">baz</div>
--- selector
div:not([class])
--- expected
<div>foo</div>

===
--- SKIP
--- input
<p>foo</p>
<div class="foo">baz</div>
--- selector
*:not(p)
--- expected
<div class="foo">baz</div>

===
--- input
<p class="pastoral blue aqua marine">foo</p>
<p class="pastoral blue">bar</p>
--- selector
p.pastoral.marine
--- expected
<p class="pastoral blue aqua marine">foo</p>

===
--- input
<p>foo</p>
<p>bar</p>
--- selector
p:nth-child(1)
--- expected
<p>foo</p>

===
--- input
<p>foo</p>
<p>bar</p>
--- selector
p:nth-child(2)
--- expected
<p>bar</p>

===
--- input
<a href="no">No</a>
<a href="foobar">Foobar</a>
<a href="barred">Barred</a>
<a href="bar">bar</a>
--- selector
a[@href*="bar"]
--- expected
<a href="foobar">Foobar</a>
<a href="barred">Barred</a>
<a href="bar">bar</a>

===
--- input
<a href="no">No</a>
<a href="foobar">Foobar</a>
<a href="barred">Barred</a>
<a href="bar">bar</a>

--- selector
a:not([@href*="bar"])
--- expected
<a href="no">No</a>

===
--- input
<p>
<a href="no">No</a>
<div>Some description</div>
<a href="foobar">Foobar</a>
<div>Some description</div>
<a href="barred">Barred</a>
<div>Some description</div>
<a href="bar">bar</a>
</p>
--- selector
p > a:nth-of-type(3)
--- expected
<a href="barred">Barred</a>

===
--- input
<a href="No">No (no preceding sibling)</a>
<p>A header</p>
<a href="Yes">Yes</a>
<div>Some description</div>
<a href="foobar">Foobar</a>
<a href="barred">Barred</a>
<p>
<a href="No">No (child, not sibling)</a>
</p>
--- selector
p ~ a
--- expected
<a href="Yes">Yes</a>
<a href="foobar">Foobar</a>
<a href="barred">Barred</a>

===
--- input
<a href="No">No (no preceding sibling)</a>
<p>A header</p>
<a class="foo" href="Yes">Yes</a>
<div>Some description</div>
<a href="foobar">Foobar</a>
<a href="barred">Barred</a>
<p>
<a class="foo" href="No">No (child, not sibling)</a>
</p>
--- selector
p ~ a.foo
--- expected
<a class="foo" href="Yes">Yes</a>
