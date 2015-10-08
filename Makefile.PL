
use strict;

use ExtUtils::MakeMaker 6.48;


my %WriteMakefileArgs = (
    NAME           => 'SSHKey::Fingerprint',
    VERSION_FROM   => 'lib/SSHKey/Fingerprint.pm',
    BUILD_REQUIRES => {

        # solely for the test-suite.
        'Test::More'   => 0,
        'Test::Pod'    => 0,
        'Test::Strict' => 0,
        'Test::NoTabs' => 0,

    },
    ABSTRACT         => 'Generate SSH-key fingerprints.',
    AUTHOR           => 'Steve Kemp <steve@steve.org.uk>',
    LICENSE          => 'perl',
    MIN_PERL_VERSION => '5.008',
    META_MERGE       => {
              resources => {
                  license    => 'http://dev.perl.org/licenses/',
                  homepage   => 'https://github.com/skx/SSHKey--Fingerprint/',
                  bugtracker => 'https://github.com/skx/SSHKey--Fingerprint/issues',
                  repository => 'https://github.com/skx/SSHKey--Fingerprint.git',
              },
    },
);


WriteMakefile(%WriteMakefileArgs);


package MY;

sub metafile
{
    my $self = shift;
    my $meta = $self->SUPER::metafile_target(@_);
    my ($extra) = $self->echo( 'license: perl_5', 'MYMETA.yml', 1 );
    return "$meta\t$extra\n";
}
