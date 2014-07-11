use strict;
use warnings;
package Git::Open;
use Moose;
use Git::Open::Util;

with 'MooseX::Getopt::Usage';

has compare => (
    is => 'ro',
    isa => 'Str',
    documentation => 'To open compare view: master-develop'
);

has generator => (
    is => 'ro',
    metaclass => 'NoGetopt',
    isa => 'Git::Open::Util',
    default => sub {
        return Git::Open::Util->new();
    },
    handles => {
        url => 'generate_url'
    },
    documentation => ''
);

# ABSTRACT: a totally cool way to open repository page, sometime it's hard to remember.

=head1 USAGE

    git open # it will open homepage of your repository

    git open --compare # it will open compare page

    git open --compare master-develop # Open compare page with branch diff

    Tip: -c is a shorthand for --compare

=cut

sub run {
    my $self = shift;

    my $url = $self->url( $self->args );
    system("git web--browse $url");
}

# TODO: Find the way to args get it from Moose
sub args {
    my $self = shift;
    return {
        compare => $self->compare()
    };
}

1;
