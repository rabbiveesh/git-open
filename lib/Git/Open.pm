use strict;
use warnings;
package Git::Open;
use Moose;
use Git::Open::Util;

use Moose::Util::TypeConstraints;

with 'MooseX::Getopt::Usage';

subtype 'MaybeStr'
    => as 'Str'
    => where { defined $_ };

MooseX::Getopt::OptionTypeMap->add_option_type_to_map(
    'MaybeStr' => ':s'
);

has compare => (
    is => 'ro',
    isa => 'MaybeStr',
    default => '',
    documentation => 'To open compare view, ex: --compare master-develop'
);

has 'branch' => (
    is => 'ro',
    isa => 'MaybeStr',
    documentation => 'To open branch view: --branch develop'
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
    }
);

# ABSTRACT: The totally cool way to open repository page, sometime it's hard to remember and open via browser manually.

=head1 USAGE

    git open # it will open homepage of your repository

    git open --compare # it will open compare page

    git open --compare master-develop # Open compare page betwee master and develop

    git open --branch master # Open master branch's page

    git open --branch # Open current branch's page

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
        compare => $self->compare(),
        branch => $self->branch()
    };
}

1;
