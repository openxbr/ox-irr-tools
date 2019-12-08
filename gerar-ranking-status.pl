#!/usr/bin/perl

$my_status = shift;

while(<>) {

	chomp;
	($status,$prefix,$asn,$origin,$maint,$source) = split /,/;
	$count{$maint}++ if $status eq $my_status;
}

foreach $maint (sort { $count{$a} <=> $count{$b} } keys %count) {
	print "$maint\t$count{$maint}\n";
}
