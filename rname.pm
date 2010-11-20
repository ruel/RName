#	File: 			rname.pm
#	Author: 		Ruel Pagayon  <ruel@ruel.me>
#	Version: 		0.1
#	Description:	This is where the functions are placed.

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

package RName;

sub usage() {
	print "[-] Usage: perl rname.pl [string-to-replace] [replacement] [path-to-directory]";
	exit();
}

sub header() {
	print "[+] (c) Copyright 2010 Ruel Pagayon <ruel\@ruel.me> - http://ruel.me\n\n";
}

sub validatepath($) {
	my $path = $_[0];
	$path =~ s/"//;
	if ($path =~ /(\/|\\)$/) {
		#nothing
	} elsif ($path =~ /(\/|\\)\w+"?$/) {
		$path .= $1;
	}
	return $path;
}

sub loadf($) {
    my @file = ( );
    open(FILE, $_[0] . "\n") or die("[+] Couldn't Open " . $_[0] . "\n");
    @file = <FILE>;
    close(FILE);
    return @file;
}

sub diro($$$) {
	my $dir = $_[0];
	my $tbr = $_[1];
	my $string = $_[2];
	opendir(my $dh, $dir) or die("[-] Can't open " . $dir);
	while (readdir $dh) {
		my $fd = $_;
		my $sub = $dir . $fd;
		if (-d $sub) {
			next unless ($fd !~ /(\.){1,2}/);
			if ($sub =~ /\\\w+$/) {
				$sub .= "\\";
			}
			else {
				$sub .= "/";
			}
			diro($sub, $tbr, $string);
		} else {
			my $nname = $sub;
			if ($nname =~ s/\Q$tbr\E/$string/g) {
				rename($sub, $nname);
				print "[+] Renamed: " . $sub . "\n";
			}
			if ($nname =~ /\.(\w+)$/) {
				my $ext = $1;
				my @ed = ( );
				foreach my $ext (loadf("exts.txt")) {
					$ext =~ s/^\s+//;
					$ext =~ s/\s+$//;
					push(@ed, $ext);
				}
				if (grep { $_ eq $ext } @ed) {
					rname($nname, $tbr, $string);
				}
			}
		}
	}
}

sub rname($$$) {
	my $p = $_[0];
	my $tbr = $_[1];
	my $string = $_[2];
	my $t = $p . ".bak";
	my $c = 0;
	rename ($p, $t);
	open (FILE, '<', $t) or die ("[-] Can't open " . $t);
	my @file = <FILE>;
	close (FILE);
	open (R, '>>', $p);
	foreach my $line (@file) {
		$line =~ s/^\s+//;
		$line =~ s/\s+$//;
		if ($line =~ s/\Q$tbr\E/$string/ig) {
			$c++;
		}
		print R $line . "\n";
	}
	close (R);
	if ($c) {
		print "[+] Success at: " . $p . "\n";
	}
	unlink($t);
}

1