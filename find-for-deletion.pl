#!/usr/bin/perl
# find-for-deletion.pl - Version 1.0
# Copyright (C) 2013-2019 Renato Ornelas - renato@openx.com.br
#
# For the latest updates, please visit https://github.com/openxbr/ox-irr-tools
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

$my_maint = shift;

while(<>) {

	chomp;
	next if /^Status/;

	($status,$prefix,$asn,$origin,$maint,$source) = split /,/;

	$asn_ok{$prefix} = $origin if $status eq "OK";

	$invalid{$prefix} = $origin if /^INVALID.*,$my_maint,/;
	$uneeded{$prefix} = "UNEEDED" if /^UNEEDED.*,$my_maint,/;
}


foreach $prefix (keys %asn_ok) {

	if ($uneeded{$prefix}) {
		$type = $prefix =~ /::/ ? "route6" : "route";
        print "password: $my_password\n" and $pass = 1 unless $pass;
		print "
$type:		$prefix
origin:		AS$asn_ok{$prefix}
mnt-by:		$my_maint
descr:		$my_desc
notify:		$my_email
changed:	$my_email $y$m$d
source:		$my_db
delete:		PROXY
";

	}
}
foreach $prefix (keys %invalid) {
		$type = $prefix =~ /::/ ? "route6" : "route";
        print "password: $my_password\n" and $pass = 1 unless $pass;
		print "
$type:		$prefix
origin:		AS$invalid{$prefix}
mnt-by:		$my_maint
descr:		$my_desc
notify:		$my_email
changed:	$my_email $y$m$d
source:		$my_db
delete:		INVALID
";
}
