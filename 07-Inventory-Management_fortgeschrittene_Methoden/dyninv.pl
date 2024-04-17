#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use JSON;
use FindBin;

# Konnektieren der Datenquelle ( = CSV-Datei )
my $dbh = DBI->connect ("dbi:CSV:f_dir=${FindBin::Bin}", undef, undef, {
    f_encoding       => "utf8",
    csv_eol          => "\n",
    csv_sep_char     => ":",
});
$dbh->{csv_tables}{hosts}  = { file => "hosts.csv"  };


# Grundeinstellungen:
my $group    = "test_hosts";
my $python   = "/usr/bin/python3";
my $ssh_args = "-o StrictHostKeyChecking=no";


# Grundgerüst der Ergebnis-Struktur in Perl:
my $info = {
    _meta => {
        hostvars => {}
    },
    $group => {
        hosts => []
    }
};


# Abfrage aller Daten:
my $sth = $dbh->prepare("SELECT host, user, method, password FROM hosts");
$sth->execute;


# Verarbeiten der Daten und Befüllen der Struktur:
while (my ($host, $user, $method, $pass) = $sth->fetchrow_array) {
    push @{ $info->{$group}{hosts} }, $host;

    $info->{_meta}{hostvars}{$host}{ansible_user}
        = $user;
    
    my $ansible_become = $method? "yes" : "no";

    $info->{_meta}{hostvars}{$host}{ansible_become}
        = $ansible_become;

    $info->{_meta}{hostvars}{$host}{ansible_become_method}
        = $method if $method;

    $info->{_meta}{hostvars}{$host}{ansible_become_pass}
        = $pass if $pass;

    $info->{_meta}{hostvars}{$host}{ansible_python_interpreter}
        = $python;
    
    $info->{_meta}{hostvars}{$host}{ansible_ssh_common_args}
        = $ssh_args;
}


# Ausgabe im JSON-Format:
my $json = JSON->new;
print $json->pretty->encode( $info );
