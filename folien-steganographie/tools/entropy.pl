#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use List::Util     qw< sum >;
use Compress::Zlib;
use Gtk2 -init;
use Gtk2::SimpleList;

my $window = Gtk2::Window->new;
$window->set_title("Entropie");
$window->signal_connect(delete_event => sub { Gtk2->main_quit });

my $vbox = Gtk2::VBox->new(0,5);

# Haupt-Eingabefeld
my $buf;
{
  my $frame = Gtk2::Frame->new("Eingabe");
  my $sw    = Gtk2::ScrolledWindow->new;
  $sw->set_policy("automatic", "automatic");

  my $entry = Gtk2::TextView->new;
  $entry->set_wrap_mode("word");
  $buf      = $entry->get_buffer;
  $entry->get_buffer->signal_connect(changed => sub { once(50 => \&show_entropy) });

  if(@ARGV) {
    local $/;
    $buf->insert_at_cursor(my $text = scalar <>);
    print "Entropie von ARGV: " . (calc_entropy($text))[3] . "\n";
  }

  $entry->set_size_request(500, 100);
  $sw->add($entry);
  $frame->add($sw);
  $vbox->pack_start($frame, 0, 0, 0);
}

{
  my %timeouts;

  sub once {
    my ($delay, $code) = @_;

    Glib::Source->remove($timeouts{$code}) if $timeouts{$code};
    $timeouts{$code} = Glib::Timeout->add($delay => sub { $code->(); return });
  }
}

my (
  $normalize,
  $textlen_label,
  $entropy_label,
  $gzip_total_label, $gzip_ratio_label, $gzip_entropy_label,
);
{
  my $frame = Gtk2::Frame->new("Informationsgehalt pro Zeichen");
  my $sw    = Gtk2::ScrolledWindow->new;
  $sw->set_policy("automatic", "automatic");

  my $list = Gtk2::SimpleList->new(
    "Zeichen"         => "text",
    "Unicode"         => "text",
    "Abs. Häufigkeit" => "int",
    "Rel. Häufigkeit" => "text",
    "Informationsgehalt in bit" => "text",
  );

  $list->set_size_request(500, 200);
  $sw->add($list);

  $frame->add($sw);
  $vbox->pack_start($frame, 0, 0, 0);

  sub show_entropy {
    my $text = $buf->get_text($buf->get_start_iter => $buf->get_end_iter, 0);
    $text = lc $text, $text =~ s/\s//g if $normalize->get_active;

    my ($abscount, $prob, $information, $entropy) = calc_entropy($text);

    $entropy_label->set_label(sprintf '%0.5f bit', $entropy || 0);

    my $gzip = Compress::Zlib::memGzip($text);
    $gzip_total_label->set_label(sprintf '%d B', length $gzip);
    $gzip_ratio_label->set_label(
      length $text
        ? sprintf '%0.5f', length($gzip) / length $text
        : "∞"
    );
    $gzip_entropy_label->set_label(sprintf '%0.05f bit', (calc_entropy($gzip))[3]);

    $textlen_label->set_label(sprintf '%d B', length $text);

    @{ $list->{data} } = map {[
      $_,
      sprintf('U+%04d', ord $_),
      $abscount->{$_},
      sprintf('%0.5f', $prob->{$_}),
      sprintf('%0.5f', $information->{$_}),
    ]} sort {
      $information->{$b} <=> $information->{$a} ||
                      $a cmp $b
    } keys %$abscount;
  }

  sub calc_entropy {
    my $text = shift;

    my %abscount;
    $abscount{$_}++ for split //, $text;

    my %prob;
    $prob{$_} = $abscount{$_} / length $text for keys %abscount;

    my %information;
    $information{$_} = -log($prob{$_}) / log 2 for keys %prob;

    my $entropy = sum map { $prob{$_} * $information{$_} } keys %prob;

    return \%abscount, \%prob, \%information, $entropy;
  }
}

{
  my $frame = Gtk2::Frame->new("Gesamtstatistik");
  my $vbox_ = Gtk2::VBox->new;

  for(
    [ "Textlänge"                           => \$textlen_label ],
    [ "Entropie"                            => \$entropy_label ],
    [ "Komprimiert mit gzip, Länge"         => \$gzip_total_label ],
    [ "Komprimiert mit gzip, auf Textlänge" => \$gzip_ratio_label ],
    [ "Komprimiert mit gzip, Entropie"      => \$gzip_entropy_label ],
  ) {
    my ($descr, $mod_label) = @$_;

    my $hbox = Gtk2::HBox->new;
    my $descr_label = Gtk2::Label->new("$descr:");
    $$mod_label     = Gtk2::Label->new;
    $descr_label->set_alignment(0, 0);
    $$mod_label ->set_alignment(1, 0);

    $hbox->add($descr_label);
    $hbox->add($$mod_label);
    $vbox_->add($hbox);
  }

  $frame->add($vbox_);
  $vbox->pack_start($frame, 1, 1, 0);
}

# Normalisierungstickbox
{
  my $frame = Gtk2::Frame->new("Optionen");

  $normalize = Gtk2::CheckButton->new_with_label("Normalisierung");
  $normalize->set_active(1);
  $normalize->signal_connect(toggled => \&show_entropy);

  $frame->add($normalize);
  $vbox->pack_start($frame, 1, 1, 0);
}

# MainLoop
show_entropy();

$window->add($vbox);
$window->show_all();
Gtk2->main();
