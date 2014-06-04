#!/usr/bin/perl

use warnings;
use strict;

use Imager;
use Getopt::Long;

# parse command line
GetOptions(
  "input=s"  => \my $input,
  "output=s" => \my $output,
  "mode=s"   => \my $mode,
  "help!"    => \&usage
);

# check parameters
if(!$mode or $mode !~ /^(embed|extract)$/i) {
  print "--mode must be either \"embed\" or \"extract\"!\n\n";
  usage(1);
} elsif (!$input or !-R $input) {
  print "--input not given or filename not readable!\n\n";
  usage(1);
} elsif(lc $mode eq "embed" and !$output) {
  print "--mode=embed but no --output filename given!\n\n";
  usage(1);
}

# open image
my $img = Imager->new;
$img->open(file => $input, type => "png");

# get heigt and width of image in pixels
my ($height, $width) = ($img->getheight, $img->getwidth);

# hide data in image
if(lc $mode eq "embed") {
  my $iter = DNSX::BitFH::Input->new(\*STDIN);
  my $i = 0;
  while(defined( my $databit = $iter->next )) {
    my $channel = $i % 3;
    my $pos = int($i / 3);
    my $y   = int($pos / $width);
    my $x   = $pos % $width;

    if($pos > $height * $width) {
      print "Data too long for image!\n";
      printf "You may save up to %d bytes in this image.\n", int($height*$width*3/8);
      exit 1;
    }

    my $color = $img->getpixel(x => $x, y => $y);
    my @rgb   = $color->rgba;
    $rgb[$channel] = 2*int($rgb[$channel] / 2) + $databit;
    $color->set(@rgb);

    $img->setpixel(x => $x, y => $y, color => $color);
    #warn "$i -> $x,$y, $channel: $databit -> $rgb[$channel]\n";

    $i++;
  }

  $img->write(file => $output);

# extract data
} else {
  my $bitfh = DNSX::BitFH::Output->new(\*STDOUT);

  for my $y (0..$height - 1) {
    for my $x (0..$width - 1) {
      my @rgb = $img->getpixel(x => $x, y => $y)->rgba;
      for my $color ((@rgb)[0..2]) {
	#warn "$x,$y: $color -> " . (($color % 2 == 0) ? 0 : 1);
	$bitfh->add($color % 2 == 0 ? 0 : 1);
      }
    }
  }

  $bitfh->flush() or die;
}

sub usage {
  print <<USAGE;
SYNONYPS:
  stega.pl [ arguments ]

DESCRIPTION:
  stega.pl is a example implementation of a simple steganography tool that
  hides information in PNG-files by manipulationg the colors.

  stega.pl manipulates the least significant bit (LSB) of every color channel
  (red, green, blue) of a pixel. Therefore you can theoretically save
  (height*width*3)/8 bytes information in a image.

  The information is read by STDIN, so you may just pipe the output of another
  programm to stega.pl.

EMBEDING:
  You have to use the embed mode to hide information in an image. The data will
  be read from STDIN.

  --input  filename of the original image in which the information should be
           saved.
  --output filename of the manipulated image that contains the information. 

EXTRACTING:
  You have to use the extract mode to hide information in an image. The output
  will be written to STDOUT.

  --input  filename of the manipulated image that contains the information.

EXAMPLES:
  \$ stega.pl --mode=embed   --input=tree.png --output=secret.png
  \$ stega.pl --mode=extract --input=hidden.png

AUTHORS:
  Ingo Blechschmidt <iblech\@web.de>,
  Michael Hartmann <michael.hartmann\@as-netz.de>
USAGE
  
  exit $_[0] ? $_[0] : 0;
}

# ------


package DNSX::BitFH::Input;

use warnings;
use strict;

sub new { bless { fh => $_[1], buf => [] } => $_[0] }

sub next {
  my $self = shift;

  if(@{ $self->buf }) {
    return shift @{ $self->buf };
  } else {
    my $byte = getc $self->fh;
    return unless defined $byte;

    for(my $i = 7; $i >= 0; $i--) {
      push @{ $self->buf }, vec $byte, $i, 1;
    }

    return $self->next;
  }
}

sub fh  : lvalue { $_[0]->{fh}  }
sub buf : lvalue { $_[0]->{buf} }


package DNSX::BitFH::Output;

use warnings;
use strict;

sub new { bless { fh => $_[1], buf => [] } => $_[0] }

sub add {
  my ($self, $bit) = @_;

  push @{ $self->buf }, $bit;

  $self->flush;
}

sub flush {
  my $self = shift;
  local $_;

  return 1 unless @{ $self->buf };

  while(@{ $self->buf } >= 8) {
    my @bits = splice @{ $self->buf }, 0, 8;
    my $byte = "";
    vec($byte, $_, 1) = $bits[7 - $_] for 0..7;
    print { $self->fh } $byte;
  }

  return 1 unless @{ $self->buf };
}

sub fh  : lvalue { $_[0]->{fh}  }
sub buf : lvalue { $_[0]->{buf} }

1;
1;
