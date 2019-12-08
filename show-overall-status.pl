#!/usr/bin/perl

while(<>) {
	chomp;
	($status,$prefixo,$asn,$origin,$maint,$source) = split /,/;
	$count{$status}++; 
}


foreach $status (sort keys %count) {
	print "$status\t$count{$status}\n";
}
