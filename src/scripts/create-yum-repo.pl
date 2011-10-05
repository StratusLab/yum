#!/usr/bin/perl -w 

use strict;

use File::Path qw(mkpath rmtree);
use File::Find;
use File::Copy qw(mv cp);

our %links;

#
# Create RPM symlinks with correct names in destination.
#
sub move_and_rename_rpms {
    my ($src, $dest) = @_;

    %links = ();

    find(\&treat_rpm, $src);

    for my $key (sort keys %links) {
        my $link = "${dest}/$key";
        if (!-l $link) {
            cp($links{$key}, $link);
        }
    }
}


#
# Collect source file name and 'internal' name from RPMs.
#
sub treat_rpm {
    if (/^.*\.rpm$/) {
        my $n = translate_rpm_name($File::Find::name);
        if ($links{$n}) {
            # Ignore collisions for now. 
            #print "COLLISION: $n\n";
            #print "CURRENT:  $File::Find::name\n";
            #print "EXISTING: $links{$n}\n";
        } else {
            $links{$n} = $File::Find::name;
        }
    }
}

#
# Update the yum repository at the given location.
#
sub update_yum_metadata {
    my ($repo) = @_;
    `createrepo --update --checkts --pretty ${repo}`;
}

#
# Use internal rpm information to generate output filename.
# The filename must include the full path to the RPM package.
#
sub translate_rpm_name {
    my ($filename) = @_;
    return `rpm -qp --qf "%{N}-%{V}-%{R}.%{ARCH}.rpm" ${filename}`;
}

############################################################

#
# Get the nexus and yum repository names.
#
my $nexus_repo_name = shift or die "must supply nexus repository name";
my $yum_repo_name = shift or die "must supply yum repository name";

#
# Create the absolute paths for these repositories.
#
my $nexus_packages = "${nexus_repo_name}";
my $externals = '/var/www/yum/externals';
my $yum_repo = "${yum_repo_name}";

#
# Create the output yum repository if it doesn't exist already.
#
mkpath(${yum_repo});

#
# Do the actual update of the repository. 
#
move_and_rename_rpms($nexus_packages, $yum_repo);

#create_rpm_symlinks($externals, $yum_repo);

update_yum_metadata($yum_repo);
