package HTTP::Tiny::Patch::SetUserAgent;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Module::Patch qw();
use base qw(Module::Patch);

our %config;

my $p_agent = sub {
    my $self = shift;

    my $agent = $config{-agent} // $ENV{HTTP_TINY_USER_AGENT};
    die "Please specify -agent configuration" unless defined $agent;

    $self->{agent} = $agent;
};

sub patch_data {
    return {
        v => 3,
        config => {
            -agent => {
                schema  => 'str*',
                req => 1,
            },
        },
        patches => [
            {
                action      => 'replace',
                mod_version => qr/^0\.*/,
                sub_name    => 'agent',
                code        => $p_agent,
            },
        ],
    };
}

1;
# ABSTRACT: Set User-Agent header

=for Pod::Coverage ^(patch_data)$

=head1 SYNOPSIS

From Perl:

 use HTTP::Tiny::Patch::SetUserAgent
     -agent => 'Foo 1.0', # required
 ;


=head1 DESCRIPTION

This


=head1 CONFIGURATION

=head2 -agent


=head1 FAQ


=head1 ENVIRONMENT

=head2 HTTP_TINY_USER_AGENT

Set default for HTTP_TINY_USER_AGENT.


=head1 SEE ALSO

L<HTTP::Tiny::Plugin::SetUserAgent>.

=cut
