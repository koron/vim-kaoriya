#!/usr/local/bin/perl
# vim:set ts=8 sts=4 sw=4 tw=0 et:

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $DIR = "/home/htdocs/files.kaoriya.net/vim";
my @FILES = qw(vim74-kaoriya-win32-test.zip vim74-kaoriya-win64-test.zip);

sub init
{
    my ($files) = @_;
    my $retval = {};
    foreach my $file (@FILES) {
        (my $pattern = $file) =~ s/(?:-test)(\.[^.]*$)/-\\d+$1/;
        my $object = {
            key => $file,
            pattern => $pattern,
            match => sub {
                return $_[0] =~ m/^${pattern}$/;
            },
            results => {},
            latest_entry => undef,
            latest_time => 0,
        };
        $retval->{$file} = $object;
    }
    return $retval;
}

sub find
{
    my ($dir, $table) = @_;

    my $count = 0;
    opendir(my $dh, $dir);
    while (my $entry = readdir($dh)) {
        next if $entry =~ m/^\./;
        my $found = 0;
        foreach my $object (values(%$table)) {
            if ($object->{match}($entry)) {
                my $value = (stat("$dir/$entry"))[9];
                $object->{results}->{$entry} = $value;
                if (not defined $object->{latest_entry}
                        or $object->{latest_time} < $value) {
                    $object->{latest_entry} = $entry;
                    $object->{latest_time} = $value;
                }
                ++$count;
                last;
            }
        }
    }
    closedir $dh;
    return $count;
}

sub update
{
    my ($dir, $table) = @_;
    print "dir: $dir\n";
    while (my ($k, $v) = each(%$table)) {
        next if not defined $v or not defined $v->{latest_entry};
        my $link = "$dir/$k";
        my $entity = "$dir/$v->{latest_entry}";
        if (-e $entity) {
            if (-e $link) {
                unlink $link;
            }
            link $entity, $link;
            print "linked: $v->{latest_entry} -> $k\n";
        }
    }
}

my $table = &init(\@FILES);
my $count = &find($DIR, $table);
&update($DIR, $table);
