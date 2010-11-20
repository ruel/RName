#!/usr/bin/perl

#	File: 			rname.pl
#	Author: 		Ruel Pagayon <ruel@ruel.me>
#	Version: 		0.1
#	Description:	This is the scripts main body.

#	This file is part of RName.
#
#   RName is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	RName is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with RName.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;
use RName;

{
	RName::header();
	RName::usage() unless (@ARGV == 3);

	my $tbr = $ARGV[0];
	my $string = $ARGV[1];
	my $path = $ARGV[2];
	$path = RName::validatepath($path);

	print "\n[+] Target:\t\t" . $path . "\n";
	print "[+] Searching for:\t" . $tbr . "\n";
	print "[+] To be replaced by:\t" . $string . "\n\n";

	RName::diro($path, $tbr, $string);
}
__END__