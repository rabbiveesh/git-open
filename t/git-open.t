use strict;
use warnings;
use Test::More;

use Test::Mock::Cmd 'qr' => {
    'git ls-remote --get-url' => sub { return 'git@github.com:abc/xzy.git' },
    'git symbolic-ref --short HEAD' => sub { return 'master'; }
};

use Git::Open;

subtest _remote_url => sub {
    my $app = Git::Open->new_with_options();
    my $url =  $app->_remote_url();
    is( $url, 'http://github.com/abc/xzy', 'Get remote url' );
};

subtest  _current_branch => sub {
    my $app = Git::Open->new_with_options();
    my $branch =  $app->_current_branch();
    is( $branch, 'master', 'Get current branch' );
};

subtest url_compare_opts => sub {
    my $opts = {
        compare => 'master-develop'
    };

    my $app = Git::Open->new_with_options($opts);
    my $url = $app->generate_url();
    is( $url, 'http://github.com/abc/xzy/compare/master...develop', 'Correct compare url with diff' );
};

done_testing();
