use utf8;
use strict;

BEGIN { binmode STDOUT, ':utf8'; binmode STDERR, ':utf8'; }

use Net::IDN::Encode qw(:all);

use Test::More tests => 1 + 6;
use Test::NoWarnings;

use Net::IDN::Encode qw(:all);

is(eval{domain_to_ascii('müller')} || $@, 'xn--mller-kva', 'single label');
is(eval{domain_to_ascii('www.jürg.xn--mller-kva.com', )} || $@, 'www.xn--jrg-hoa.xn--mller-kva.com', 'mixed utf8/ace/ascii');
is(eval{domain_to_ascii('www.a.b。c．d｡com', )} || $@, 'www.a.b.c.d.com', 'mixed dots');
is(eval{domain_to_ascii('www.xn--a o u -1za7prc.org', 'UseSTD3ASCIIRules' => 0)}, undef, 'blank (without STD3 rules)');
is(eval{domain_to_ascii('www.xn--a o u -1za7prc.org', 'UseSTD3ASCIIRules' => 1)}, undef, 'blank (with STD3 rules)');
is(eval{domain_to_ascii('www.xn--garbage')}, 'www.xn--garbage', 'Invalid A-label');
