#!/usr/bin/perl

while(<>) {

	chomp;
	($status,$prefix,$asn,$origin,$maint,$source) = split /,/;
	$count{$maint}++ if $status ne "NOT_FOUND"; 
}

foreach $maint (sort { $count{$a} <=> $count{$b} } keys %count) {
	print "$maint\t$count{$maint}\n";
}
