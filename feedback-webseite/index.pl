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
Liebe Eltern,

hier haben Sie Gelegenheit für anonymes Feedback: Was ist gut gelaufen, was schlecht, was können wir nächstes Jahr besser machen?:
/SONSTIGES/

Wir danken Ihnen herzlich für Ihre Unterstützung!

Ihr Team vom Mathecamp:
Meru Alagalingam, Veronika Auer, Martin Baur, Ingo Blechschmidt, Tim Dafler, Justin Gassner, Christoph Gräupner, Kathrin Helmsauer, Andreas Hohl, Matthias Hutzler, Alexander Mai, Dorothea Pörtge, Veronika Pörtge, Sven Prüfer, Lisa Reischmann, Raphael Schlarb, Max Schlögel, Matthias Schlüter, Dominik Schmucker, David Wiedemann, Rolf Wittmann, Carina Ziegler
TMPL
use constant ANON_GRUSS => "Viele Grüße\neine anonyme Teilnehmerin oder ein anonymer Teilnehmer deines Zirkels";

my %courses = (
# a00_camptermin => {
#   name => "Mathecamp",
#   text => CAMPTERMIN,
#   mail => 'iblech@speicherleck.de',
# },
  a00_camp => {
    name => "Mathecamp",
    text => CAMP,
    mail => 'iblech@speicherleck.de',
    formal => 1,
  },
  a_05 => {
    name => "Präsenzzirkel bei Dominik und Hannah (5./6. Klasse, Mi 16:30)",
    text => PRAESENZ,
    mail => 'd.schmucker1995@gmail.com,hanhant@web.de',
    anrede => "Lieber Dominik, liebe Hannah",
    gruss  => ANON_GRUSS,
  },
  a_06 => {
    name => "Präsenzzirkel bei Katharina, Anna und David (6./7. Klasse, Di 16:00)",
    text => PRAESENZ,
    mail => 'katharina.ohlhoff@web.de,anna-rubeck@web.de,wiedemann.david.1996@googlemail.com',
    anrede => "Liebe Katharina, liebe Anna, lieber David",
    gruss  => ANON_GRUSS,
  },
  a_07 => {
    name => "Präsenzzirkel bei Matthias, Marco und Felix (7./8. Klasse, Di 17:15)",
    text => PRAESENZ,
    mail => 'matthias.ralph.hutzler@student.uni-augsburg.de,marco.lilienblum@web.de,felixstaerk@gmail.com',
    anrede => "Lieber Matthias, lieber Marco, lieber Felix",
    gruss  => ANON_GRUSS,
  },
  a_08 => {
    name => "Präsenzzirkel bei Tim, Alexander und Benjamin (8./9. Klasse, Fr 16:30)",
    text => PRAESENZ,
    mail => 'tim@timbaumann.info,alex.m.s@gmx.de,bennymoeckl@icloud.com',
    anrede => "Lieber Tim, lieber Alex, lieber Ben",
    gruss  => ANON_GRUSS,
  },
  a_09 => {
    name => "Präsenzzirkel bei Andreas H., Andreas P. und Maximilian (10./11./12. Klasse, Di 17:15)",
    text => PRAESENZ,
    mail => 'hohl.andreas@web.de,andreaspetrak@yahoo.de,maxschloegel@gmx.net',
    anrede => "Liebe Andreasse, lieber Max",
    gruss  => ANON_GRUSS,
  },
  k_12 => {
    name => "Korrespondenzzirkel bei Simone und Raphael (12. Klasse)",
    text => KORRESPONDENZ,
    mail => 'beyser.simone@gmail.com,raphia1992@gmail.com',
    anrede => "Liebe Simone, lieber Raphael",
    gruss  => ANON_GRUSS,
  },
  k_11 => {
    name => "Korrespondenzzirkel bei Alexei und Moritz (11. Klasse)",
    text => KORRESPONDENZ,
    mail => 'alexei.kudryashov@math.uni-augsburg.de,moritz.oli3@hotmail.com',
    anrede => "Lieber Alexei, lieber Moritz",
    gruss  => ANON_GRUSS,
  },
  k_10 => {
    name => "Korrespondenzzirkel bei Caecilia und Rolf (10. Klasse)",
    text => KORRESPONDENZ,
    mail => 'caecilia.johanna.froehler@student.uni-augsburg.de,rolf.klemens.wittmann@student.uni-augsburg.de',
    anrede => "Liebe Caecilia, lieber Rolf",
    gruss  => ANON_GRUSS,
  },
  k_09 => {
    name => "Korrespondenzzirkel bei Kathrin (9. Klasse)",
    text => KORRESPONDENZ,
    mail => 'kathrin.helmsauer@math.uni-augsburg.de',
    anrede => "Liebe Kathrin",
    gruss  => ANON_GRUSS,
  },
  k_08 => {
    name => "Korrespondenzzirkel bei Dominik und Lukas (8. Klasse)",
    text => KORRESPONDENZ,
    mail => 'lukas.graf@t-online.de,Dominik-Dirr@web.de',
    anrede => "Lieber Dominik, lieber Lukas",
    gruss  => ANON_GRUSS,
  },
  k_07 => {
    name => "Korrespondenzzirkel bei Christian und Tanja (7. Klasse)",
    text => KORRESPONDENZ,
    mail => 'Lochner.Christian@gmx.net,tanja.wolfer@gmx.de',
    anrede => "Lieber Christian, liebe Tanja",
    gruss  => ANON_GRUSS,
  },
  k_06 => {
    name => "Korrespondenzzirkel bei Jessica und Matthias (6. Klasse)",
    text => KORRESPONDENZ,
    mail => 'mandljessi@web.de,matthias.schlueter-mp@web.de',
    anrede => "Liebe Jessi, lieber Matthias",
    gruss  => ANON_GRUSS,
  },
  k_05 => {
    name => "Korrespondenzzirkel bei Lisa und Caren (5. Klasse)",
    text => KORRESPONDENZ,
    mail => 'reischmann_lisa@yahoo.de,caren.schinko@web.de',
    anrede => "Liebe Lisa, liebe Caren",
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
