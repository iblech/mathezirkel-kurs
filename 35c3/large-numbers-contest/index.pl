#!/usr/bin/env perl

use warnings;
use strict;

use lib glob "/nix/store/*CGI*/lib/perl5/site_perl/5.28.0";
use lib glob "/nix/store/*File-Slurp*/lib/perl5/site_perl/5.28.0";

use CGI;
use Encode;
use File::Slurp qw< slurp >;
use FindBin;
use Digest::SHA qw< sha256_hex >;
use POSIX       qw< strftime >;

use constant MAX_AUTHOR_SIZE => 4096;
use constant MAX_ENTRY_SIZE  => 4096;
use constant MAX_ENTRIES     => 20000;
use constant DIGEST_COOKIE   => "Digest Cookie";

chdir "$FindBin::Bin/submissions" or die;
die if (my $num_entries =()= glob("*.txt")) > MAX_ENTRIES;

my $q = CGI->new();

my $current_id     = "";
my $current_author = "";
my $current_entry  = "";

if($ENV{REQUEST_URI} =~ /\/(\w{64})$/) {
    my $id = $1;

    if(-r "$id.txt") {
        $current_id = $id;
        my $data = slurp("$id.txt");
        ($current_author, $current_entry) = split "\n", $data, 2;
    }
}

if($q->request_method() eq "POST") {
    my $author  = $q->param("author");
    my $entry   = $q->param("entry");
    my $prev_id = $q->param("previous-id");

    die unless $author =~ /^[^\n]*$/ and length($author) <= MAX_AUTHOR_SIZE;
    die unless 1 <= length($entry) && length($entry) <= MAX_ENTRY_SIZE;

    my $data = "$author\n$entry";
    my $id = sha256_hex(DIGEST_COOKIE . $data);
    open my $fh, ">", "$id.txt" or die $!;
    print $fh $data or die $!;
    close $fh or die $!;

    if($prev_id ne $id and -e "$prev_id.txt") {
        unlink "$prev_id.txt";
    }

    print $q->redirect("./$id");
    exit;
}

print $q->header(-type => "text/html; charset=UTF-8");

print <<TMPL;
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="initial-scale=1">
<title>35c3 large numbers contest</title>

<style type="text/css">
  body { font-family: sans-serif; margin-left: auto; margin-right: auto;
  max-width: 42em; padding: 0.5em; }

  input, textarea { width: 90%; padding: 0.5em; font-family: inherit; }
  textarea { height: 15em; }

  .thanks { font-weight: bold; color: #a5f; }

  .good { color: #999; }
  .bad  { color: #f00; }
</style>

<script type="text/javascript" src="Blob.min.js" integrity="sha384-MG7Lggyp+OUyBrMW3tR3KBbprZ1KcLgioplA119xGtRoItlp5pzMHtwY095aCCFM"></script>

<script type="text/javascript">
    var tm = {};

    function soon(callback) {
        if(tm[callback]) window.clearTimeout(tm[callback]);

        tm[callback] = window.setTimeout(callback, 50);
    }

    function updateStatus () {
        var size = new Blob([document.getElementById("entry").value]).size;
        document.getElementById("status").innerHTML = size <= 4096
            ? "<span class=good>" + (4096 - size) + " bytes left</span>"
            : "<span class=bad>" + (size - 4096) + " bytes too many</span>";
    }
</script>

</head>

<body onload="updateStatus()">

<img src="phantoms.jpeg" style="width: 90%">

<h1>35c3 large numbers contest</h1>

<p class="good">Currently there are @{[ $num_entries ]} submissions.
@{[ $num_entries < 10 ? "Be among the first ten!" : "" ]}</p>

@{[ $current_id ? "<p class=\"thanks\">Thank you for your submission. Your
entry has been saved. In case you later want to edit your entry, bookmark this
page. The contest results will be announced here and <a
href=\"...\">at the talk</a>.</p>" : "" ]}

@{[ $current_id
    ? "<h2>Edit entry</h2>"
    : "<h2>New entry</h2>"
]}

<form method="post" action=".">
  <input type="hidden" name="previous-id" value="$current_id">

  <p>
    <label for="author">Your name (or a pseudonym; can be left blank; will be
    made public after the contest ends):</label><br>
    <input type="text" id="author" name="author" value="@{[ $q->escapeHTML($current_author) ]}">
  </p>

  <p>
    <label for="entry">Your entry (max. 4096 bytes):</label><br>
    <textarea id="entry" name="entry" onkeyup="soon(updateStatus)" onchange="updateStatus()">@{[ $q->escapeHTML($current_entry) ]}</textarea><br>
    <span id="status"></span>
  </p>

  <p>
    <input type="submit" value="submit">
  </p>
</form>


<h2>Rules</h2>

<ul>
  <li><p>The contest ends on Day 3 at XX:00 Leipzig local time. The winner is
  whoever submits the <strong>largest number</strong>. They are
  awarded <strong>1000 bars of chocolate</strong>, divided by their winning
  entry. In case of a tie, the prize is shared. Additionally there will be a
  <strong>nerdy consolation prize</strong> for every participant.</p><p>The winner
  will be announced on this page and in the <a href="...">talk on large
  numbers, very large numbers and extremely larger numbers</a>. (This talk will
  also show you how to win this contest.)</p></li>

  <li><p>Submissions may be in English or German. The only requirement is that
  the description can be expected to be understood by a working
  mathematician and objectively determines a unique (finite) positive natural
  number.</p>
  <p>Hence submissions such as <q>6.28</q>, <q>infinity</q>,
  <q>&omega;</q> (this refers to the first <a href="https://events.ccc.de/congress/2018/wiki/index.php/Session:Wondrous_Mathematics:_Fun_with_infinitely_large_numbers">infinite</a> ordinal
  number) and <q>this large number I was just thinking of</q> are
  disqualified.</p>
  <p>Examples for valid submissions are: <q>47</q>, <q>the number of assemblies
  as listed on the 35c3 wiki</q>, <q>999*999</q>. None of these examples is
  particularly large, you can surely do better. :-)</p>
  <p>You may use arbitrary technical terms and constructions in your
  description, as long as the jury will be reasonably able to look up their
  definitions on Wikipedia or the mathematical literature. Your description may
  include pseudo code computing the large number you mean.</p></li>

  <li><p>You can team up with your friends. Simply enter all your names or a team
  name.</p></li>

  <li><p>After submitting an entry, you can edit your entry as often as you
  wish. You may also submit entirely new entries. If you make multiple
  submissions, the largest one counts.</p></li>

  <li><p>It's easy to denial-of-service the server. Please don't do it. :-)</p></li>

  <li><p>Enjoy your time on 35c3!</p></li>
</ul>

</body>
TMPL
