#!/usr/bin/perl

use warnings;
use strict;

use IO::Socket;

my $PORT = 1234;

my $socket = IO::Socket::INET->new(
  LocalPort => $PORT,
  Proto     => "udp",
) or die $!;

while(1) {
  $socket->recv(my $data, 1024);

  print "$data";
  system "xdotool", "key", "--clearmodifiers", "--", split //, $data;
}
