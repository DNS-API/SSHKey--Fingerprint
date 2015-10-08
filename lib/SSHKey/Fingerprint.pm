use strict;
use warnings;

package SSHKey::Fingerprint;

use File::Temp qw/ tempfile /;

our $VERSION = '0.0.1';


=head2 new

The constructor.

This takes a hash of parameters, only one of which is used a key called C<key>
will contain the SSH-public-key.

=cut

sub new
{
    my ( $proto, %supplied ) = (@_);
    my $class = ref($proto) || $proto;

    my $self = {};
    bless( $self, $class );

    # Save the key
    $self->{ 'key' } = $supplied{ 'key' } if ( $supplied{ 'key' } );

    return $self;
}


=head2 valid

Is the key valid?  Return 1 on success, 0 on failure.

=cut

sub valid
{
    my ( $self, %params ) = (@_);

    my $key = $params{ 'key' } || $self->{ 'key' } || undef;
    die "Missing key" unless ($key);

    #
    #  Split into expected parts.
    #
    my @parts = split( / /, $key );

    #
    #  This should be non-empty.
    #
    return 0 unless (@parts);

    #
    #  We expect three parts.
    #
    return 0 unless ( scalar(@parts) == 3 );


    #
    #  The first part will be:
    #
    #    ssh-dsa
    #  or
    #    ssh-dss
    #  or
    #    ssh-rsa
    #  or
    #    ssh-ed25519
    #  or
    #    ecdsa-sha2-nistp256
    #
    if ( $parts[0] =~
         /(ssh-dsa|ssh-dss|ssh-rsa|ssh-ed25519|ecdsa-sha2-nistp256)/ )
    {
        return 1;
    }

    return 0;
}


=head2 fingerprint

Return the fingerprint of the key, via the invokation of C<ssh-keygen>.

=cut

sub fingerprint
{
    my ( $self, %params ) = (@_);

    my $key = $params{ 'key' } || $self->{ 'key' } || undef;
    die "Missing key" unless ($key);

    # Write out to temporary file.
    my ( $fh, $filename ) = tempfile();
    print $fh $key;
    close($fh);

    # Run the command.
    open( my $handle, "-|", "ssh-keygen -lf $filename" );
    my $fingerprint = <$handle>;
    close($handle);

    if ($fingerprint)
    {
        my @d = split( /[ \t]/, $fingerprint );
        $fingerprint = $d[1];
    }

    unlink($filename) if ( -e $filename );

    return ($fingerprint);
}

1;
