#!/usr/bin/perl
# show-overall-status.pl - Version 0.9
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

while(<>) {
	chomp;
	($status,$prefixo,$asn,$origin,$maint,$source) = split /,/;
	$count{$status}++; 
}


foreach $status (sort keys %count) {
	print "$status\t$count{$status}\n";
}
