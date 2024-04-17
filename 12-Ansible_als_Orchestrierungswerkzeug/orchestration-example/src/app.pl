#!/usr/bin/perl
use Mojolicious::Lite;
use File::Basename;
use Sys::Hostname;

our $VERSION  = '1.0';
my  $progname = basename $0;

get '/' => sub {
    my $c = shift;

    my $text = "";
    $text .= "$progname, version $VERSION\n";
    $text .= "Hostname: " . hostname() . "\n";

    $c->render(text => $text);
};

app->start;
