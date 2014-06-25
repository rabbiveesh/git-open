package Git::Open::Service::Github;
use strict;
use warnings;
use Moose;

with 'Git::Open::Service::Git';

sub compare_page_url {
    my $self = shift;
    my $opt  = shift;

    $opt =~ s/-/\.\.\./g;
    $opt = "compare/$opt";
    return $opt;
};

__PACKAGE__->meta->make_immutable;

1;
