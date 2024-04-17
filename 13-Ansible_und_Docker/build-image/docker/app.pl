#!/usr/bin/perl
use warnings;
use strict;

use CGI;

my $q = CGI->new();
print $q->header;

print "<h1>Hallo aus einem Perl-CGI-Programm!<h1>\n";
