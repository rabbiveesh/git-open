use strict;
use warnings;
package Git::Open::Util;
use Moose;

has remote_url => (
    is      => 'ro',
    isa     => 'Str',
    default => sub {
        my $git_url = `git ls-remote --get-url`;

        $git_url =~ s/\n//;
        $git_url =~ s/:/\//; # Change : to /
        $git_url =~ s/^git@/http:\/\//; # Change protocal to http
        $git_url =~ s/\.git$//; # Remove .git at the end
        return $git_url;
    }
);

has current_branch => (
    is      => 'ro',
    isa     => 'Str',
    default => sub {
        my $current_branch = `git symbolic-ref --short HEAD`;
        return $current_branch;
    }
);

has service => (
    is => 'ro',
    lazy => 1,
    default => sub {
        # TODO: Load class by remote URL
        use Git::Open::Service::Github;
        return Git::Open::Service::Github->new;
    }
);

sub generate_url {
    my $self = shift;
    my $args = shift;

    my $suffix;
    # TODO: add branch & pull request
    if( $args->{compare} ) {
        $suffix = $self->service->compare_page_url( $args->{compare} );
    }

    return $self->remote_url.'/'.$suffix;
};

1;

