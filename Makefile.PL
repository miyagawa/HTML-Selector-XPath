use inc::Module::Install;
name 'HTML-Selector-XPath';
all_from 'lib/HTML/Selector/XPath.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
