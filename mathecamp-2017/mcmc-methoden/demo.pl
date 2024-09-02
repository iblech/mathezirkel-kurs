#!/usr/bin/env perl

use warnings;
use strict;

use Time::HiRes qw< sleep >;

my ($total_rows, $total_cols) = ($ARGV[0] || 6, $ARGV[1] || 6);
my ($avail_rows, $avail_cols) = ($ARGV[2] || 5, $ARGV[3] || 3);

sub plot {
  my ($board, $highlight) = @_;

  print "\033[H\033[J";
  print "Using ${avail_rows}x${avail_cols} of ${total_rows}x${total_cols}...\n\n";
  for my $i (0..$total_rows-1) {
    for my $j (0..$total_cols-1) {
      my $do_highlight = $highlight && $i == $highlight->[0] && $j == $highlight->[1];
      print "\033[31;1m" if $do_highlight;
      print $board->[$i][$j] ? "██" : ($i < $avail_rows && $j < $avail_cols) ? "▒▒" : "░░";
      print "\033[0m" if $do_highlight;
    }
    print "\n";
  }

  if(is_sub($board)) {
    print "-- HIT --\n";
  } else {
    print "\n";
  }
}

sub clone {
  my $board = shift;

  my $new_board = [];
  push @$new_board, [ @$_ ] for @$board;

  return $new_board;
}

sub lookup {
  my ($board, $i, $j) = @_;

  return unless $i >= 0 and $i < $total_rows;
  return unless $j >= 0 and $j < $total_cols;

  return $board->[$i][$j];
}

sub is_valid {
  my $board = shift;

  for my $i (0..$total_rows-1) {
    for my $j (0..$total_cols-1) {
      return 0
        if $board->[$i][$j] and
          (lookup($board,$i,$j+1) or lookup($board,$i,$j-1) or lookup($board,$i-1,$j) or lookup($board,$i+1,$j));
    }
  }

  return 1;
}

sub enum_single_row {
  my $cols = shift;

  return 2 if $cols == 1;

  return +($cols > 2 ? enum_single_row($cols-2) : 1) + enum_single_row($cols-1);
}

sub enum {
  my ($board, $r, $c) = @_;

  my $total_valid = 0;

  for my $value (0, 1) {
    $board->[$r][$c] = $value;
    if($c < $total_cols-1) {
      $total_valid += enum($board, $r, $c+1);
    } elsif($r < $total_rows-1) {
      $total_valid += enum($board, $r+1, 0);
    } else {
      $total_valid += 1 if is_valid($board);
    }
  }

  return $total_valid;
}

print(enum(empty_board(), 0,0)),     exit if $ENV{enum} and $total_rows > 1;
print(enum_single_row($total_cols)), exit if $ENV{enum} and $total_rows == 1;

sub is_sub {
  my $board = shift;

  if($avail_rows >= 2) {
    for my $j (0..$total_cols-1) {
      return 0 if $board->[$avail_rows-1][$j];
    }
    return 1;
  } else {
    die if $avail_cols == 1;

    return 0 if $board->[0][$avail_cols-1];
    return 1;
  }
}

sub empty_board {
  my $board = [];
  push @$board, [ (0) x $total_cols ] for 1..$total_rows;

  return $board;
}

my $board = empty_board();

my $total  = 0;
my $in_sub = 0;
my $total_steps = 0;

my $delay = $ENV{fast} ? 0 : 0.5;

system "tput civis";

while(1) {
  if($total_steps == 10000) {
    $total  = 0;
    $in_sub = 0;
  }

  my ($i, $j) = (int rand $avail_rows, int rand $avail_cols);
  if($delay > 0.1 or $total % 10 == 0) {
    plot($board, [$i,$j]);
    print  "\n";
    print  "total: $total\n";
    print  "hits:  $in_sub\n";
    printf "ratio: %.3f\n", $total / $in_sub if $in_sub > 0;
    print STDERR $total / $in_sub, "\n" if $in_sub > 0 and ($delay > 0.1 or $total % 1000 == 0);
  }
 
  my $candidate_board = clone($board);
  $candidate_board->[$i][$j] = 1 - $board->[$i][$j];

  $board = $candidate_board if is_valid($candidate_board);

  $total_steps++;
  $total++;
  $in_sub++ if is_sub($board);

  sleep $delay;
  $delay /= 1.02;
}
