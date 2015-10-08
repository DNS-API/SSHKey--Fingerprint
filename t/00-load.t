#!/usr/bin/perl -Iblib/lib/

use strict;
use warnings;

use Test::More tests => 3;

BEGIN
{
    use_ok( "SSHKey::Fingerprint", "We could load the module" );
}

ok( $SSHKey::Fingerprint::VERSION, "Version defined" );
ok( $SSHKey::Fingerprint::VERSION =~ /^([0-9\.]+)/, "Version is numeric" );
