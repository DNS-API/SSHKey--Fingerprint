SSHKey::Fingerprint
===================

This repository contains the source for the perl module `SSHKey::Fingerprint`, which is designed to generate a fingerprint from a given SSH public-key.

This is useful for when you need to show a user a list of public keys
they've uploaded/permitted.  The fingerprint is a more useful identifier
than the actual string of characters.



Usage
-----

There are only three API methods:

* `new()`
    * Creates a new object.
* `valid()`
    * Tests to see if a given key is valid.
* `fingerprint()`
    * Return the key's fingerprint.

Usage of all three methods is demonstrated in this sample code:


    use SSHKey::Fingerprint;

    my $o = SSHKey::Fingerprint->new( key => "ssh-rsa ...." );

    if ( $o->valid() ) {
        print "Fingerprint: " . $o->fingerprint() . "\n";
    }


NOTES
-----

This module ultimately executes the `ssh-keygen` binary, so that must
be installed and on your `$PATH`.    I've run [american fuzzy lop](http://lcamtuf.coredump.cx/afl/) for multiple hours against generated key-samples, to the extent I'm reasonably sure that this is not a risky operation.

Steve
--
