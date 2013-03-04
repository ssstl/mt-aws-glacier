# mt-aws-glacier - Amazon Glacier sync client
# Copyright (C) 2012-2013  Victor Efimov
# http://mt-aws.com (also http://vs-dev.com) vs@vs-dev.com
# License: GPLv3
#
# This file is part of "mt-aws-glacier"
#
#    mt-aws-glacier is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    mt-aws-glacier is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

package App::MtAws::Utils;


use strict;
use warnings FATAL => 'all';
use utf8;
use File::Spec;
use Carp;

require Exporter;
use base qw/Exporter/;


our @EXPORT_OK = qw(sanity_relative_filename is_relative_filename);


# Does not work with directory names
sub sanity_relative_filename
{
	my ($filename) = @_;
	return undef unless defined $filename;
	return undef if $filename =~ m!^//!g;
	$filename =~ s!^/!!;
	return undef if $filename =~ m![\r\n\t]!g;
	$filename = File::Spec->catdir( map {return undef if m!^\.\.?$!; $_; } split('/', File::Spec->canonpath($filename)) );
	return undef if $filename eq '';
	return $filename;
}

sub is_relative_filename # TODO: test
{
	my ($filename) = @_;
	my $newname = sanity_relative_filename($filename);
	return defined($newname) && ($filename eq $newname); 
}

1;

__END__