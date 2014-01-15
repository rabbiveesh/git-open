use strict;
use warnings;
package Git::Open;


sub url_scheme {
    my $git_url = `git ls-remote --get-url`;

    $git_url =~ s/\n//;
    $git_url =~ s/:/\//; # Change : to /
    $git_url =~ s/^git@/http:\/\//; # Change protocal to http
    $git_url =~ s/\.git$//; # Remove .git at the end
    return $git_url;
}

sub current_branch {
    my $current_branch = `git symbolic-ref --short HEAD`;
    return $current_branch;
}

1;

# ABSTRACT: turns baubles into trinkets
