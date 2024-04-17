#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $pass_prefix = "ansible/vault";

my $id;
GetOptions("vault-id=s" => \$id);

exec "pass" , "$pass_prefix/$id";
