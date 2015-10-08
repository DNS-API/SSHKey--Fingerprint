SSHKey::Fingerprint
===================

This repository contains the source for the perl module `SSHKey::Fingerprint`, which is designed to allow a user to create an SSH fingerprint given a public-key.

Usage is as simple as:

    use SSHKey::Fingerprint;

    my $o = SSHKey::Fingerprint->new( key => "ssh-rsa ...." );

    if ( $o->valid() ) {
        print "Fingerprint: " . $o->fingerprint() . "\n";
    }



Steve
--
