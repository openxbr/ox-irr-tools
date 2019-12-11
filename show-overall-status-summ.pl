#!/usr/bin/perl

while(<>) {

	next if /^Status/;
	chomp;
	($status,$prefixo,$asn,$origin,$maint,$source) = split /,/;
	$count{$status}++; 
}
foreach $status (sort keys %count) {
	print "$status\t";
}
print "\n";
foreach $status (sort keys %count) {
	print "$count{$status}\t";
}
print "\n";
