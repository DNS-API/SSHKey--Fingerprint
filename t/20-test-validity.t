#!/usr/bin/perl -Iblib/lib/
#
#  This test has a number of keys hardwired into it, and asserts
# that those keys have specific fingerprints.
#
# Steve
# --
#


use strict;
use warnings;

use Test::More tests => 11;

#
# Load the module
#
BEGIN {use_ok("SSHKey::Fingerprint")}
require_ok("SSHKey::Fingerprint");


#
#  Our test-data
#
my %data = (
    'cb:91:2c:b4:52:1d:37:df:41:58:db:24:49:95:a7:3a' =>
      'ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLTJ5+rWoq5cNcjXdhzRiEK3Yq6tFSYr4DBsqkRI0ZqJdb+7RxbhJYUOq5jsBlHUzktYhOahEDlc9Lezz3ZUqXg= username@example',
    'f8:61:31:7b:00:9f:1d:02:94:96:77:47:14:32:e6:05' =>
      'ssh-dss AAAAB3NzaC1kc3MAAACBANHgVhdllCHCtQMc+quSKr9RqdkrjUI2ZJ2+5Hn0b71mDZJiuHjN7eM556gCETc25YrT1+40QYakvx2AHMzSNQo/tmOtcOuhY8q+Uzfg65l9jYw/rBgQs7dVO0azUE27tRe4zJOurxElq5nN5bICHYg4q7rziF/B69Z7hIWHkJJZAAAAFQDV78A+nNModv7QIU3Kbz+4E7AANQAAAIEAl+X/wWdJLGdD1VIALJZAVmdGpzO5CG2C1MZAlhMlduTm6p9wTbw7/m6XVMQB4/8qDJwBPHieiEkeLwmdr5SVEmimfYo88H1RJVtK38OCBMAuUHcN9fKCV3ZNbWMVgbIpkjxZuWBT+8palnawJxuIO0bialJwbWmgTgTJphA2opAAAACBAKaULTFIDzgunPFPYVvEyQ7Oee15XA/rUr8ykoeGzmK+KqAi6YEnvzl45fq7BJ6NU52dMJHMHVBB2LjBo0mM/moZnVVK/xrHTboujvwglAJj20f5Y4TmI/7QU4fK19RPc1xrklejcOuOSpkQaSrObnZxhxIkhsWrnTSIcklIWhNV username@example',
    '9e:64:9f:4b:19:6f:7a:c4:29:37:94:88:b4:c6:4a:f9' =>
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFIt9oXLKo6QhlYsSdpYF9/OMx3wCKuEANsVOvDG31DVc5csBjPIEiB+FdY9rp6kuC2D10rnn1dYoXH9IIqkskuBX2nGRsvHCrQ2p7DGZuQFvcWXbpbFvWgNhfeXS0o/FbH3mW9+a0odkA94WN9rJfKbW8mjp8s5GDFx9PBTVbfkWk2ieWOwZmiTRl13v1ZdGtmra92H1hZN7R/2mMuUuDTEOr+cMuKmkbpwxSdj/ECd0t05GCmiNQ0ldRbrEViTbQiiKMwEsVS9So014fGSBzbLO3w/p1s0sz8lAmZaTFHklwyTnvkNSrPOnmNFw+YxxzUArxnQCNCEWloxNpunXX username@example'
);


#
#  Test each key/fingerprint pair.
#
foreach my $fingerprint ( sort keys %data )
{
    my $key = $data{ $fingerprint };

    #
    #  Create the helpler.
    #
    my $helper = SSHKey::Fingerprint->new( key => $key );
    isa_ok( $helper, "SSHKey::Fingerprint" );

    #
    #  Test we get the correct results
    #
    is( $helper->valid(), "1", "The key is valid." );
    is( $helper->fingerprint(), $fingerprint,
        "The key has the correct fingerprint." );
}

