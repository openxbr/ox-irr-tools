#!/usr/bin/perl

# ox_irr_new_customer.pl - Version 0.9
# Copyright (C) 2013-2019 Renato Ornelas - renato@openx.com.br
#
# For the latest updates, please visit http://github.com/openx/
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

require "ox_irr_config.pl";

sub usage {
    print<<HELP
$0 [OPTIONS] [ASN...]
  -f         force generation of objets even if they exist;
  -d         show invalid objects (wrong origin)
  -h         display this help text and exit

HELP
}

foreach $arg (@ARGV) {
    $debug = 1 if $arg eq "-d";
    $force = 1 if $arg eq "-f";
    usage if $arg eq "-h";
}

use Net::IRR;

my $i = Net::IRR->connect( host => $irr_host ) 
    or die "can't connect to $host\n";

($y,$m,$d) = (localtime)[5,4,3];

$y+=1900;
$m = sprintf("%02d", $m+1);
$d = sprintf("%02d", $d);

# GET ALL PREFIXES FOR AN ASN
foreach $as (@ARGV) {

    $as =~ s/^AS//;
    $whois = `whois -h $whois_host AS$as`;

    foreach $ln (split /\n/, $whois) {
        next unless $ln =~ /^inetnum:\s+(.+)$/;
        $as{$as} = 1;
        $pfx{$1} = $as;
    }
}

print "password: $my_password\n";

foreach $pfx (sort keys %pfx) {
    $pfx_ok = 0;

    if(not $force) {
        $routes =  $i->route_search("$pfx", Net::IRR::EXACT_MATCH);

        $routes =~ s/AS//g;
        @asn = split / /, $routes;

        foreach $as (@asn) { 
            if($as == $pfx{$pfx}) {
                $pfx_ok = 1;
            } 
            else {
                print STDERR "WARN: $pfx exists with wrong origin: $as\n" if $debug;
            }
        }
    }

    $tipo = $pfx =~ /::/ ? "route6:" : "route: ";

    if ($force or not $pfx_ok) { 
        print<<IRR
$tipo     $pfx
descr:      $my_desc
origin:     AS$pfx{$pfx}
mnt-by:     $my_maint
notify:     $my_email
changed:    $my_email $y$m$d
remarks:    $localtime 
source:     $my_db

IRR
    }
}

$i->disconnect();
