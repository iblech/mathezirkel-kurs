#!/usr/bin/perl

use warnings;
use strict;
use utf8;

use Gtk2 -init;

my $window = Gtk2::Window->new;
$window->set_title("Tastaturverzögerung");
$window->signal_connect(delete_event => sub { Gtk2->main_quit });

my $vbox = Gtk2::VBox->new(1,5);

# Haupt-Eingabefeld
{
  my $frame = Gtk2::Frame->new("Eingabe");

  my $entry = Gtk2::Entry->new;
  $entry->signal_connect(changed => sub { delayed_mirror($entry->get_text) });

  $frame->add($entry);
  $vbox->pack_start($frame, 1, 1, 0);
}

# Verzögertes Mirror-Feld
my $spin;
{
  my $frame = Gtk2::Frame->new("Verzögerte Ausgabe");

  my $entry = Gtk2::Entry->new;
  $entry->set_editable(0);

  $frame->add($entry);
  $vbox->pack_start($frame, 1, 1, 0);

  sub delayed_mirror {
    my $text = shift;
    {
      no warnings "void";
      $entry;  # Bug in perl
    }

    Glib::Timeout->add($spin->get_value => sub {
      $entry->set_text($text);
      return;
    });
  }
}

# Delay-Veränderungsfeld
{
  my $frame = Gtk2::Frame->new("Verzögerung [ms]");

  $spin = Gtk2::SpinButton->new_with_range(0, 2000, 1);

  $frame->add($spin);
  $vbox->pack_start($frame, 1, 1, 0);
}

# MainLoop
$window->add($vbox);
$window->show_all();
Gtk2->main();
