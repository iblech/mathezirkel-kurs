\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anschreiben}[2013/03/29 LaTeX class]

\LoadClass[a4paper,ngerman,12pt]{scrartcl}

\RequirePackage[utf8]{inputenc}

\RequirePackage[ngerman]{babel}

\RequirePackage{amsmath,amsthm,amssymb,stmaryrd,color,graphicx}

\RequirePackage[protrusion=true,expansion=true]{microtype}

\RequirePackage{lmodern}

\RequirePackage{geometry}
\geometry{tmargin=2cm,bmargin=2cm,lmargin=2.5cm,rmargin=2.5cm}

\RequirePackage{hyperref}

\setlength\parskip{\medskipamount}
\setlength\parindent{0pt}

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

\pagestyle{empty}

\setlength{\unitlength}{1cm}

\newcommand{\anschrift}{}
\newcommand{\betreff}{}
\newcommand{\datum}{}
\newcommand{\deinName}{}
\newcommand{\deineMailAdresse}{}

\newcommand{\makeletterhead}{%
  \includegraphics[scale=0.1]{logo-ifm}\par
  \begin{picture}(0,0)
    \put(0,0){%
      {\tiny Uni Augsburg -- Mathesch\"ulerzirkel -- Inst. f. Math. -- 86135
      Augsburg}
    }
    \put(0,-2.5){\vbox{\anschrift}}
    \put(10,-4.5){\vbox{
      \small
      \begin{tabbing}
        Telefax \= \kill
        \textbf{\deinName} \\
      \ \\
      Mathesch\"ulerzirkel \\
      Universität Augsburg \\
      Institut für Mathematik \\
      86135 Augsburg \\
      \ \\      
      \textsf{\deineMailAdresse} \\
        \rule{174pt}{0.25mm} \\
        Augsburg, den \datum
      \end{tabbing}
    }}
  \end{picture}\par
  \vspace{5cm}
  \textbf{\betreff}\par
  \vspace{1em}}

\def\chopline#1;#2;#3;#4;#5;#6;#7;#8 \\{
  \def\vorname{#2}
  \def\nachname{#3}
  \def\geschlecht{#4}
  \def\strasse{#6}
  \def\plz{#7}
  \def\ort{#8}
}

\newif\ifganzeklasse\ganzeklassefalse
\newif\ifweiblich\weiblichtrue
\newif\ifmore\moretrue

\RequirePackage{xstring}
    
\newcommand{\bearbeitezeile}{
	\expandafter\chopline\zeile\\
  \IfSubStr{\geschlecht}{x}{\ganzeklassetrue}{\ganzeklassefalse}
  \IfSubStr{\geschlecht}{w}{\weiblichtrue}{\weiblichfalse}
	\ifganzeklasse
		\renewcommand{\anschrift}{
			\vorname\\ \nachname \\
			\strasse{} \\
			\plz~\ort}
		\makeletterhead
	\else
		\renewcommand{\anschrift}{
		  \vorname~\nachname \\
      \strasse \\
      \plz~\ort}
		\makeletterhead
	\fi}