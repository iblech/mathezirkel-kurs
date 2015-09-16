#!/usr/bin/perl

use warnings;
use strict;

use CGI;

use constant PRAESENZ => <<TMPL;
insgesamt hat mir die letzte Zirkelstunde /insgesamt:sehr gut,gut,mittel,schlecht,sehr schlecht/ gefallen.
Das Thema fand ich /thema:sehr interessant,interessant,normal,langweilig,sehr langweilig/.
Das Niveau war /haerte:genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht/.

Für die nächsten Male wünsche ich mir, dass /Wunsch/.

Folgendes möchte ich noch loswerden: /Sonstiges/.
TMPL

use constant PRAESENZ_INGO => <<TMPL;
insgesamt hat mir die letzte Zirkelstunde /insgesamt:krass schlecht,sehr gut,gut,mittel,schlecht,sehr schlecht,Ich war nicht da!/ gefallen.
Das Thema fand ich /thema:unendlich öde,sehr interessant,interessant,normal,langweilig,sehr langweilig,Ich war nicht da!/.
Das Niveau war /haerte:völlig verwirrt,genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht,Ich war nicht da!/.

Für die nächsten Male wünsche ich mir, dass /Wunsch/.

Ich habe /haskell:großes,neutrales,kein/ Interesse an einem einmaligen separaten Zirkel außer der Reihe, bei dem wir erste Schritte mit der Programmiersprache Haskell machen.

Ich wünsche mir folgendes Thema für den nächsten Zirkel: /neu1:Fortsetzung unserer Tour durch Zahlentheorie,Programmierung von Quantencomputern,Erste Schritte in der (Nicht-Quanten-)Programmiersprache Haskell,Buffonsche Nadelproblem,Erzeugende Funktionen,Fermi-Probleme,Neuronale Netze,Harte Knobelaufgaben,Fraktale,Funktionentheorie,Homologie,Sonstiges (siehe Freitextfeld)/

Ich wünsche mir folgendes Thema für den übernächsten Zirkel: /neu2:Fortsetzung unserer Tour durch Zahlentheorie,Programmierung von Quantencomputern,Erste Schritte in der (Nicht-Quanten-)Programmiersprache Haskell,Buffonsche Nadelproblem,Erzeugende Funktionen,Fermi-Probleme,Neuronale Netze,Harte Knobelaufgaben,Fraktale,Funktionentheorie,Homologie,Sonstiges (siehe Freitextfeld)/

Buffonsche Nadelproblem: Lasse ein Streichholz wiederholt auf einen Boden aus Holzdielen fallen. Der Abstand von zwei Dielen sei genauso groß wie das Streichholz lang ist. Zähle, wie oft das Streichholz die Grenze zwischen zwei Dielen trifft. Diese Zahl, geteilt durch die Gesamtzahl, wie oft das Streichholz insgesamt gefallen ist, ist 2 / pi. Wieso? Wie kommt pi plötzlich ins Spiel? Was hat das mit Kreisen zu tun? Für dieses verblüffende Resultat gibt es sehr komplizierte und auch wunderbar einfache Beweise. Ein schönes Thema, dass sich für eine einzelne Zirkelstunde eignet.

Erzeugende Funktionen: Mit sog. erzeugenden Funktionen kann man viele kombinatorische Zählprobleme rein über Rechnungen lösen, ohne kompliziert nachdenken zu müssen. Das fängt bei einfachen Fragen wie "Wie viele Möglichkeiten gibt es, k Personen auf n Plätze zu verteilen?" an, kann aber auch auf kompliziertere Probleme wie "Wie viele Zerlegungen der Zahl n gibt es?" (zum Beispiel: 4 = 2 + 2, 4 = 3 + 1, 4 = 1 + 1 + 1 + 1, ...), "Wie viele Gebilde aus Knotenpunkten und Kanten gibt es, wobei die Beschränkungen BLA, BLI und BLUBB eingehalten werden sollen?", "Wie kann man eine explizite Formel für die n-te Fibonaccizahl finden?" angewendet werden. Ein schönes Thema, dass sich für eine oder mehrere Zirkelstunden eignet. Es kommen hier auch wieder unendliche Summen vor; ich glaube, dafür haben sich ein paar von euch interessiert.

Fermi-Probleme: Wie viele Pizzas werden in Deutschland pro Jahr bestellt? Wie viele Luftballons braucht man, um eine Turnhalle vollständig zu füllen? Aus wie viel Zellen besteht der menschliche Körper? Wie viele erdähnliche Planeten gibt es im sichtbaren Universum? Solche Fragen verlangen gute Überschlagsrechnungen. Man lernt, mit Unsicherheiten quantitativ umzugehen. Eignet sich für eine bis unendlich viele Zirkelstunden, wobei es vielleicht irgendwann langweilig wird. :-)

Funktionentheorie: Ihr kennt ja schon komplexe Zahlen. Funktionentheorie ist eines der schönsten Dinge, die man mit komplexen Zahlen anstellen kann. Es ist ein großes und schönes Gebiet der Mathematik. Ich würde folgenden Aspekt herausgreifen: Wie kann man, mithilfe von komplexen Zahlen, ganz gewöhnliche Integrale, die nichts mit komplexen Zahlen zu tun haben, super leicht auswerten? (Integrieren ist das Gegenteil von Differenzieren.) Ein schönes Thema, dass sich für eine oder zwei Stunden eignet.

Fraktale: Googelt am besten selbst nach dem Apfelmännchen. Wie entstehen diese Figuren? Ein anschauliches Thema, dass sich für eine oder zwei Stunden eignet.

Neuronale Netze: Wie kann ein Computer Fotos von faulen Äpfeln von Fotos von guten Äpfeln unterscheiden? Wie kann ein Computer handschriftlich gekrakelte Ziffern erkennen? Wie kann ein Computer Gesichter erkennen? Neuronale Netze sind eine Möglichkeit, das zu machen. Das gehört zum Gebiet der künstlichen Intelligenz. Ein Thema mit klarem Praxisbezug, eignet sich für zwei bis vier Zirkelstunden.

Folgendes möchte ich noch loswerden: /Sonstiges/.
TMPL

use constant KORRESPONDENZ => <<TMPL;
insgesamt hat mir der letzte Zirkelbrief /insgesamt:sehr gut,gut,mittel,schlecht,sehr schlecht/ gefallen.
Das Thema fand ich /thema:sehr interessant,interessant,normal,langweilig,sehr langweilig/.
Das Niveau war /haerte:genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht/.

Die Bearbeitung der Aufgaben hat mir /spass:sehr viel,viel,wenig,sehr wenig/ Spaß gemacht.
Besonders schön war Aufgabe /schoeneaufgabe/. Mit Aufgabe /schlechteaufgabe/ bin ich gar nicht zurande gekommen.

Für die nächsten Briefe wünsche ich mir, dass /Wunsch/.

Folgendes möchte ich noch loswerden: /Sonstiges/.
TMPL

use constant KORRESPONDENZ_CHRISTIAN => <<TMPL;
insgesamt hat mir der letzte Zirkelbrief /insgesamt:sehr gut,gut,mittel,schlecht,sehr schlecht/ gefallen.
Das Thema fand ich /thema:sehr interessant,interessant,normal,langweilig,sehr langweilig/.
Das Niveau war /haerte:genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht/.

Die Bearbeitung der Aufgaben hat mir /spass:sehr viel,viel,wenig,sehr wenig/ Spaß gemacht.
Besonders schön war Aufgabe /schoeneaufgabe/. Mit Aufgabe /schlechteaufgabe/ bin ich gar nicht zurande gekommen.

Für die nächsten Briefe wünsche ich mir, dass /Wunsch/.

Ich möchte /krypt:sehr,egal,nicht/, dass wir mit Kryptographie weitermachen.

Für die nächsten Themen habe ich folgende Vorschläge: /Themenvorschlaege/

Folgendes möchte ich noch loswerden: /Sonstiges/.
TMPL

my %courses = (
  a01_carina => {
    name => "Korrespondenzzirkel bei Carina (5. Klasse)",
    text => KORRESPONDENZ,
    mail => 'carina.willbold@math.uni-augsburg.de',
    anrede => "Liebe Carina",
  },
  a02_dominik => {
    name => "Korrespondenzzirkel bei Dominik und Lukas (6./7. Klasse)",
    text => KORRESPONDENZ,
    mail => 'Dominik-Dirr@web.de,lukas.graf@t-online.de',
    anrede => "Lieber Dominik, lieber Lukas",
  },
  a02b_ralph => {
    name => "Korrespondenzzirkel bei Ralph (8./9./10. Klasse)",
    text => KORRESPONDENZ,
    mail => 'ralph.lettau@math.uni-augsburg.de,iblech@speicherleck.de',
    anrede => "Lieber Ralph",
  },
  a03_christian => {
    name => "Korrespondenzzirkel bei Christian (10./11/12. Klasse)",
    text => KORRESPONDENZ_CHRISTIAN,
    mail => 'christian.huebschmann@student.uni-augsburg.de',
    anrede => "Lieber Christian",
  },
  a04_meru => {
    name => "Wettbewerbszirkel bei Meru (7./8./9. Klasse)",
    text => KORRESPONDENZ,
    mail => 'alagalingam@googlemail.com',
    anrede => "Lieber Meru",
  },
  a05_philipp => {
    name => "Präsenzzirkel bei Philipp (Mo 16:30)",
    text => PRAESENZ,
    mail => 'philipp.dueren@googlemail.com',
    anrede => "Lieber Philipp",
  },
  a06_caren => {
    name => "Präsenzzirkel bei Caren (Mi 17:15)",
    text => PRAESENZ,
    mail => 'caren.schinko@web.de',
    anrede => "Liebe Caren",
  },
  a07_sven => {
    name => "Präsenzzirkel bei Sven (Do 16:15)",
    text => PRAESENZ,
    mail => 'sven.pruefer@math.uni-augsburg.de',
    anrede => "Lieber Sven",
  },
  a08_ingo => {
    name => "Präsenzzirkel bei Ingo (Fr 15:45)",
    text => PRAESENZ_INGO,
    mail => 'iblech@web.de',
    anrede => "Lieber Ingo",
  },
);

my $q   = CGI->new;
my $cid = $q->param("course");

print $q->header(
  -type    => "text/html; charset=UTF-8",
);

print <<TMPL;
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Rückmeldung zum Matheschülerzirkel</title>
<style type="text/css">
@{[ do { open my $fh, "<", "style.css"; local $/; <$fh> } ]}
</style>
</head>

<body>
TMPL

if($q->param("ack") and defined $cid and exists $courses{$cid}) {
  my $msg = <<TMPL;
$courses{$cid}{anrede},

$courses{$cid}{text}
Viele Grüße
eine anonyme Teilnehmerin oder ein anonymer Teilnehmer deines Zirkels
TMPL

  my $msgH = format_html_result($msg, $q);
  $msg =~ s#/(\w+):?(.*?)/#$q->param($1)#eg;

  $msg = <<TMPL;
Rückmeldung zum $courses{$cid}{name}
IP-Adresse: $ENV{REMOTE_ADDR}
Browser: $ENV{HTTP_USER_AGENT}

$msg
TMPL

  print qq{
    <h1>Vielen Dank!</h1>

    <div class="page">
    <p>Deine Rückmeldung ist uns sehr wichtig, damit wir die Zirkel verbessern
    können. Wenn dir später noch weitere Anregungen, Ideen oder
    Wünsche einfallen, kannst du das Formular einfach erneut ausfüllen.</p>
    <p>Du kannst dieses Fenster jetzt schließen.</p>
    <div class="letter"><p>$msgH</p></div>
    </div>
  };

  open my $fh, "|-",
    "mail", "-s", "Rückmeldung zu deinem Mathezirkel",
    $courses{$cid}{mail} or die $!;
  print $fh $msg or die $1;
  close $fh or die $1;
} elsif(not defined $cid or not exists $courses{$cid}) {
  print qq{
    <h1>Rückmeldung zum Matheschülerzirkel</h1>

    <div class="page">
      <p>Liebes Team vom Mathezirkel,</p>

      <p>ich möchte Rückmeldung zu folgendem Zirkel abgeben:
      </p>
      <ul>
  };

  for my $id (sort keys %courses) {
    print "<li><p><a href=\"?course=$id\">$courses{$id}{name}</a></p></li>";
  }

  print qq{
      </ul>
    </div>
  };
} else {
  print qq{
    <h1>Rückmeldung zum $courses{$cid}{name}</h1>

    <div class="page">
    <form method="post">
      <input type="hidden" name="course" value="$cid" />
      <input type="hidden" name="ack" value="ack" />

      <p>$courses{$cid}{anrede},</p>
      @{[ format_html_form($courses{$cid}{text}) ]}
      <p>Viele Grüße<br />
      eine anonyme Teilnehmerin oder ein anonymer Teilnehmer deines Zirkels</p>

      <div class="attention">
        <input type="submit" value="Rückmeldung abschicken!" />
      </div>
    </form>
    </div>
    <div class="note">Dein Feedback erhält nur deine Zirkelleiterin bzw. dein
    Zirkelleiter.</div>
  };
}

print <<TMPL;

<img style="position: absolute; right: 10px; bottom: 10px; width: 185px; height: 262px" src="gregor-small.png" alt="Das Maskottchen des Matheschülerzirkels" />

</body>
</html>
TMPL

sub format_html_form {
  my $tmpl = shift;

  $tmpl =~ s#$#<br />#gm;
  $tmpl =~ s#/(\w+):?(.*?)/#
    if(length $2) {
      qq{<select name="$1">
        @{[ map { "<option value=\"$_\">$_</option>" } split /,/, $2 ]}
      </select>};
    } else {
      my $name = $1;
      if($name =~ /^[A-Z]/) {
        qq{<input name="$name" class="long" />};
      } else {
        qq{<input name="$name" class="short" />};
      }
    }
  #eg;

  return "<p>$tmpl</p>";
}

sub format_html_result {
  my ($msg, $q) = @_;
  chomp $msg;

  $msg =~ s#$#<br />#mg;
  $msg =~ s#/(\w+):?(.*?)/#$q->escapeHTML("" . $q->param($1))#eg;

  return $msg;
}
