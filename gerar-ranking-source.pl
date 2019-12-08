#!/usr/bin/perl

while(<>) {

	chomp;
	($status,$prefix,$asn,$origin,$maint,$source) = split /,/;
	$count{$source}++ if $status ne "NOT_FOUND"; 
}

foreach $source (sort { $count{$a} <=> $count{$b} } keys %count) {
	print "$source\t$count{$source}\n";
}
