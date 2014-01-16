use strict;
use warnings;
package Git::Open;

# ABSTRACT: a totally cool way to open repository page, sometime it's hard to remember.

sub _remote_url {
    my $git_url = `git ls-remote --get-url`;

    $git_url =~ s/\n//;
    $git_url =~ s/:/\//; # Change : to /
    $git_url =~ s/^git@/http:\/\//; # Change protocal to http
    $git_url =~ s/\.git$//; # Remove .git at the end
    return $git_url;
}

sub _current_branch {
    my $current_branch = `git symbolic-ref --short HEAD`;
    return $current_branch;
}

1;
