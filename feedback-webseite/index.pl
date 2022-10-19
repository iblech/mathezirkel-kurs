#!/usr/bin/perl

use warnings;
use strict;

use CGI;

use constant PRAESENZ => <<TMPL;
ANREDE,

insgesamt hat mir die letzte Zirkelstunde /insgesamt:sehr gut,gut,mittel,schlecht,sehr schlecht/ gefallen.
Das Thema fand ich /thema:sehr interessant,interessant,normal,langweilig,sehr langweilig/.
Das Niveau war /haerte:genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht/.

Für die nächsten Male wünsche ich mir, dass /Wunsch/.

Folgendes möchte ich noch loswerden: /Sonstiges/.

GRUSS
TMPL

use constant PRAESENZ_INGO => <<TMPL;
ANREDE,

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

GRUSS
TMPL

use constant KORRESPONDENZ => <<TMPL;
ANREDE,

insgesamt hat mir der letzte Zirkelbrief /insgesamt:sehr gut,gut,mittel,schlecht,sehr schlecht/ gefallen.
Das Thema fand ich /thema:sehr interessant,interessant,normal,langweilig,sehr langweilig/.
Das Niveau war /haerte:genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht/.

Die Bearbeitung der Aufgaben hat mir /spass:sehr viel,viel,wenig,sehr wenig/ Spaß gemacht.
Besonders schön war Aufgabe /schoeneaufgabe/. Mit Aufgabe /schlechteaufgabe/ bin ich gar nicht zurande gekommen.

Für die nächsten Briefe wünsche ich mir, dass /Wunsch/.

Folgendes möchte ich noch loswerden: /Sonstiges/.

GRUSS
TMPL

use constant KORRESPONDENZ_CHRISTIAN => <<TMPL;
ANREDE,

insgesamt hat mir der letzte Zirkelbrief /insgesamt:sehr gut,gut,mittel,schlecht,sehr schlecht/ gefallen.
Das Thema fand ich /thema:sehr interessant,interessant,normal,langweilig,sehr langweilig/.
Das Niveau war /haerte:genau richtig,viel zu schwer,etwas zu schwer,etwas zu leicht,viel zu leicht/.

Die Bearbeitung der Aufgaben hat mir /spass:sehr viel,viel,wenig,sehr wenig/ Spaß gemacht.
Besonders schön war Aufgabe /schoeneaufgabe/. Mit Aufgabe /schlechteaufgabe/ bin ich gar nicht zurande gekommen.

Für die nächsten Briefe wünsche ich mir, dass /Wunsch/.

Ich möchte /krypt:sehr,egal,nicht/, dass wir mit Kryptographie weitermachen.

Für die nächsten Themen habe ich folgende Vorschläge: /Themenvorschlaege/

Folgendes möchte ich noch loswerden: /Sonstiges/.

GRUSS
TMPL

use constant CAMPTERMIN => <<TMPL;
Liebe Eltern,

mit dieser Umfrage möchten wir herausfinden, welche Präferenzen es auf Ihrer Seite für den Termin des Mathecamps 2016 gibt. Bitte kreuzen Sie dazu die Ferienwochen an, an denen Ihr Kind bzw. Ihre Kinder am Mathecamp teilnehmen könnten. Mehrfachauswahlen sind dabei selbstverständlich möglich.

Wir bitten Sie aber auch gleich vorab um Entschuldigung, wenn wir den Wunschtermin nicht realisieren können. Etwa war dieses Jahr das Bruder-Klaus-Heim nur noch in einer einzigen Woche frei – der, die wir dann für das Mathecamp gebucht haben.

//TERMINAUSWAHL//

Bei dieser Gelegenheit können Sie uns gerne auch noch etwas anderes mitteilen (was ist gut gelaufen, was schlecht, was können wir nächstes Jahr besser machen?):
/SONSTIGES/

Wir danken Ihnen herzlich für Ihre Unterstützung!

Ihr Team vom Mathecamp:
Meru Alagalingam, Tim Baumann, Martin Baur, Ingo Blechschmidt, Philipp Düren, Alexander Engel, Andrea Geck, Kathrin Helmsauer, Andreas Hohl, Saadettin Karaca, Jorid Kretzschmar, Dorothea Pörtge, Veronika Pörtge, Sven Prüfer, Lisa Reischmann, Max Schloegel, Peter Uebele, Florian Wadas, Carina Willbold
TMPL

use constant CAMP => <<TMPL;
Liebe Teilnehmer:innen, liebe Eltern,

hier haben Sie Gelegenheit für anonymes Feedback: Was ist gut gelaufen, was schlecht, was können wir nächstes Jahr besser machen?:
/SONSTIGES/

Wir danken Ihnen herzlich für Ihre Unterstützung!

Ihr Team vom Mathecamp:
Dr. Meru Alagalingam ۰ Adrian Antz ۰ Tanja Bien ۰ Prof. Dr. Lisa Beck ۰ Prof. Dr. Kai Cielibak ۰
Dr. Ingo Blechschmidt ۰ Giacomo Cozzi ۰ Prof. Dr. Mirjam Dür ۰ Ferdinand Eitler ۰ Prof. Dr. Urs Frauenfelder ۰
Prof. Dr. Sarah Friedrich ۰ Kathrin Gimmi ۰ Prof. Dr. Marco Hien ۰ Alexander Hilpert ۰ Jonas Kell ۰
Samuel Keplinger ۰ Maximilian Keßler ۰ Georgi Kocharyan ۰ Godo Kurten ۰ David Lisson ۰ Alexander Mai ۰
Prof. Dr. Marc Nieper-Wißkirchen ۰ Leonie Nießeler ۰ Thanh Mai Pham ۰ Jeanette Plechinger ۰ Dr. Sven Prüfer ۰
Anna Rubeck ۰ Kilian Rueß ۰ Dominik Schmucker ۰ Felix Stärk ۰ Louisa Völker
TMPL
use constant ANON_GRUSS => "Viele Grüße\nein:e anonyme:r Teilnehmer:in deines Zirkels";

my %courses = (
# a00_camptermin => {
#   name => "Mathecamp",
#   text => CAMPTERMIN,
#   mail => 'iblech@speicherleck.de',
# },
  a00_camp => {
    name => "Mathecamp",
    text => CAMP,
    mail => 'mathezirkel@math.uni-augsburg.de',
    formal => 1,
  },
  a_05 => {
    name => "Präsenzzirkel bei Jessica und David (5./6. Klasse, Mi 17:45 Uhr)",
    text => PRAESENZ,
    mail => 'jessica.ploner24@gmail.com,davidlisson@icloud.com',
    anrede => "Liebe Jessica, lieber David",
    gruss  => ANON_GRUSS,
  },
  a_07 => {
    name => "Präsenzzirkel bei Alex (7./8. Klasse, Fr 16:00 Uhr)",
    text => PRAESENZ,
    mail => 'alex.mai@posteo.net',
    anrede => "Lieber Alex",
    gruss  => ANON_GRUSS,
  },
  a_08a => {
    name => "Präsenzzirkel bei Giacomo (8. Klasse, Do 17:30 Uhr)",
    text => PRAESENZ,
    mail => 'giacomo.cozzi@student.uni-augsburg.de',
    anrede => "Hey Giacomo",
    gruss  => ANON_GRUSS,
  },
  a_08b => {
    name => "Präsenzzirkel bei Anna und Leonie (8./9. Klasse, Do 16:00 Uhr)",
    text => PRAESENZ,
    mail => 'anna.jaumann@student.uni-augsburg.de,leonie.schaefer@student.uni-augsburg.de',
    anrede => "Liebe Anna, liebe Leonie",
    gruss  => ANON_GRUSS,
   },
  a_09 => {
    name => "Präsenzzirkel bei Katha und Jonas (9./10. Klasse, Mo 17:30)",
    text => PRAESENZ,
    mail => 'katha.schmid-erkheim@outlook.de,jonas.rubeck@gmail.com',
    anrede => "Liebe Katha, lieber Jonas",
    gruss  => ANON_GRUSS,
  },
  a_11 => {
    name => "Präsenzzirkel bei Jonas (11./12. Klasse, Mi 19:00)",
    text => PRAESENZ,
    mail => 'jonas-kell@web.de',
    anrede => "Lieber Jonas",
    gruss  => ANON_GRUSS,
  },
  k_05 => {
    name => "Korrespondenzzirkel bei Jonas (5. Klasse)",
    text => KORRESPONDENZ,
    mail => 'jonas-kell@web.de',
    anrede => "Lieber Jonas",
    gruss  => ANON_GRUSS,
  },
  k_06 => {
    name => "Korrespondenzzirkel bei Louisa (6. Klasse)",
    text => KORRESPONDENZ,
    mail => 'louisa.voelker@gmail.com',
    anrede => "Liebe Louisa",
    gruss  => ANON_GRUSS,
   },
  k_07 => {
    name => "Korrespondenzzirkel bei Sarah (7. Klasse)",
    text => KORRESPONDENZ,
    mail => 'sarah.felber@yeti2.de',
    anrede => "Liebe Sarah",
    gruss  => ANON_GRUSS,
  },
  k_08 => {
    name => "Korrespondenzzirkel bei Domi (8. Klasse)",
    text => KORRESPONDENZ,
    mail => 'd.schmucker1995@gmail.com',
    anrede => "Lieber Domi",
    gruss  => ANON_GRUSS,
  },
  k_09 => {
    name => "Korrespondenzzirkel bei Lukas (9. Klasse)",
    text => KORRESPONDENZ,
    mail => 'giacomo.cozzi@student.uni-augsburg.de',
    anrede => "Lieber Lukas",
    gruss  => ANON_GRUSS,
  },
  k_10 => {
    name => "Korrespondenzzirkel bei Katha und Jonas (10. Klasse)",
    text => KORRESPONDENZ,
    mail => 'katha.schmid-erkheim@outlook.de,jonas.rubeck@gmail.com',
    anrede => "Liebe Katha, lieber Jonas",
    gruss  => ANON_GRUSS,
  },
  k_11 => {
    name => "Korrespondenzzirkel bei Sven (11. und 12. Klasse)",
    text => KORRESPONDENZ,
    mail => 'sven@musmehl.dem',
    anrede => "Lieber Sven",
    gruss  => ANON_GRUSS,
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

my $msg;
if(defined $cid and exists $courses{$cid}) {
  $msg = $courses{$cid}{text};
  $msg =~ s/ANREDE/$courses{$cid}{anrede}/g;
  $msg =~ s/GRUSS/$courses{$cid}{gruss}/g;
}

if($q->param("ack") and defined $cid and exists $courses{$cid}) {
  use Data::Dumper;
  my $msgH = format_html_result($msg, $q);
  $msg =~ s#//TERMINAUSWAHL//#"Mögliche Wochen: " . join ", ", $q->param("termin")#eg;
  $msg =~ s#/(\w+):?(.*?)/#$q->param($1)#eg;

  $msg = <<TMPL;
Rückmeldung zum $courses{$cid}{name}
IP-Adresse: $ENV{REMOTE_ADDR}
Browser: $ENV{HTTP_USER_AGENT}

$msg
TMPL

  if($cid eq "a00_camptermin") {
    print q{
      <h1>Vielen Dank!</h1>
      <div class="page">
        <p>Wir haben Ihre Präferenzen vermerkt. Ihre Rückmeldung ist uns sehr wichtig. Wenn Sie später noch weitere Anregungen, Ideen oder
        Wünsche haben, können Sie sich jederzeit gerne an uns wenden: per Mail an <a href="mailto:mathezirkel@math.uni-augsburg.de">mathezirkel@math.uni-augsburg.de</a> oder telefonisch unter 0821/598-5601 (Sven Prüfer).</p>
        <p>Sie können dieses Fenster jetzt schließen.</p>
      </div>
    };
  } else {
    my $danke = $courses{$cid}{formal}
        ? "<p>Ihre Rückmeldung ist uns sehr wichtig, damit wir die Zirkel
        verbessern können. Wenn Ihnen später noch weitere Anregungen, Ideen
        oder Wünsche einfallen, können Sie das Formular einfach erneut
        ausfüllen.</p><p>Sie können dieses Fenster jetzt schließen.</p>"
        : "<p>Deine Rückmeldung ist uns sehr wichtig, damit wir die Zirkel
        verbessern können. Wenn dir später noch weitere Anregungen, Ideen oder
        Wünsche einfallen, kannst du das Formular einfach erneut
        ausfüllen.</p><p>Du kannst dieses Fenster jetzt schließen.</p>";
    print qq{
      <h1>Vielen Dank!</h1>

      <div class="page">
      $danke
      <div class="letter"><p>$msgH</p></div>
      </div>
    };
  }

  open my $fh, "|-",
    "mail", "-s", "Rueckmeldung zu deinem Mathezirkel",
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

      @{[ format_html_form($msg) ]}

      <div class="attention">
        <input type="submit" value="Rückmeldung abschicken!" />
      </div>
    </form>
    </div>
  };

  if(not defined $cid or $cid ne "a00_camptermin") {
    print qq{
      <div class="note">Dein Feedback erhält nur deine Zirkelleiterin bzw. dein
      Zirkelleiter.</div>
    };
  }
}

print <<TMPL;

<img style="position: absolute; right: 10px; bottom: 10px; width: 185px; height: 262px" src="gregor-small.png" alt="Das Maskottchen des Matheschülerzirkels" />

</body>
</html>
TMPL

sub format_html_form {
  my $tmpl = shift;

  $tmpl =~ s#$#<br />#gm;
  $tmpl =~ s#//TERMINAUSWAHL//#
    <fieldset>
      <label for="check1">
        <input type="checkbox" name="termin" value="1" id="check1">
        1. Ferienwoche: 30.7.2016 bis  5.8.2016
      </label>
      <br />
      <label for="check2">
        <input type="checkbox" name="termin" value="2" id="check2">
        2. Ferienwoche:  6.8.2016 bis 12.8.2016
      </label>
      <br />
      <label for="check3">
        <input type="checkbox" name="termin" value="3" id="check3">
        3. Ferienwoche: 13.8.2016 bis 19.8.2016
      </label>
      <br />
      <label for="check4">
        <input type="checkbox" name="termin" value="4" id="check4">
        4. Ferienwoche: 20.8.2016 bis 26.8.2016
      </label>
      <br />
      <label for="check5">
        <input type="checkbox" name="termin" value="5" id="check5">
        5. Ferienwoche: 27.8.2016 bis  2.9.2016
      </label>
      <br />
      <label for="check6">
        <input type="checkbox" name="termin" value="6" id="check6">
        6. Ferienwoche:  3.9.2016 bis  9.9.2016
      </label>
    </fieldset>
  #g;
  $tmpl =~ s#/(\w+):?(.*?)/#
    if(length $2) {
      qq{<select name="$1">
        @{[ map { "<option value=\"$_\">$_</option>" } split /,/, $2 ]}
      </select>};
    } else {
      my $name = $1;
      if($name =~ /^[A-Z]+$/) {
        qq{<textarea name="$name" rows="10" cols="70"></textarea>};
      } elsif($name =~ /^[A-Z]/) {
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
  $msg =~ s#//TERMINAUSWAHL//#
    $q->escapeHTML(join ",", $q->param("termin"))
  #eg;
  $msg =~ s#/(\w+):?(.*?)/#$q->escapeHTML("" . $q->param($1))#eg;

  return $msg;
}
