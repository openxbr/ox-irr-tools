#!/usr/bin/perl

require "ox_irr_config.pl";

$my_maint = shift;

while(<>) {

	chomp;

	($status,$prefix,$asn,$origin,$maint,$source) = split /,/;

	$asn_ok{$prefix} = $origin if $status eq "OK";

	$delete{$prefix} = "INVALID" if /^INVALID.*,$my_maint,/;
	$delete{$prefix} = "PROXY" if /^PROXY.*,$my_maint,/;
}


foreach $prefix (keys %asn_ok) {

	if ($delete{$prefix}) {
		$type = $prefix =~ /::/ ? "route6" : "route";
		print "
$type:		$prefix
origin:		AS$asn_ok{$prefix}
mnt-by:		$my_maint
descr:		$my_desc
notify:		$my_email
changed:	$my_email $y$m$d
source:		$my_db
delete:		$delete{$prefix}
";

	}
	

}
