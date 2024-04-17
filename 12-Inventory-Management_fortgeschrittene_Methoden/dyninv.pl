#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use JSON;
use FindBin;
use Getopt::Long;

my %opts;

# Die zwei möglichen Optionen:
GetOptions(\%opts, "list", "host=s");
           

# Verbindung zur Datenquelle ( = CSV-Datei ) herstellen
my $dbh = DBI->connect ("dbi:CSV:f_dir=${FindBin::Bin}", undef, undef, {
    f_encoding       => "utf8",
    csv_eol          => "\n",
    csv_sep_char     => ":",
});
$dbh->{csv_tables}{hosts}   = { file => "hosts.csv"  };
$dbh->{csv_tables}{groups}  = { file => "groups.csv"  };


# Grundeinstellungen:
my %host_defaults = (
    ansible_ssh_common_args =>
    "-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null",
    ansible_python_interpreter => "/usr/bin/python3"
);


my $hosts = {};

# Abfrage aller Hosts:
my $sth = $dbh->prepare(
    "SELECT host, user, become, method, password FROM hosts"
);
$sth->execute;

while (my ($host, $user, $become, $method, $password)
       = $sth->fetchrow_array) {
    
    $hosts->{$host} = {
        %host_defaults,
        ansible_user => $user,
    };
    if ($become eq 'yes') {
        $hosts->{$host}{ansible_become} = 'yes';
        $hosts->{$host}{ansible_become_method} = $method;
    };
    if ($password) {
        $hosts->{$host}{ansible_become_pass} = $password;
    };
}


if (defined $opts{host}) { # Aufruf: --host <HOSTNAME>
    my $json = JSON->new;
    print $json->pretty->encode( $hosts->{ $opts{host} } );
    exit;
}

# Ansonsten muss es wohl der Aufruf --list sein:
exit unless defined $opts{list};

my $info   = {};
my $groups = {};

# Abfrage aller Gruppen:
$sth = $dbh->prepare("SELECT group, members FROM groups");
$sth->execute;

while (my ($group, $members) = $sth->fetchrow_array) {
    my @members = split(/,/, $members);
    $groups->{$group} = [@members];
}


$info = $groups;
$info->{_meta}{hostvars} = $hosts;

my $json = JSON->new;
print $json->pretty->encode( $info  );
