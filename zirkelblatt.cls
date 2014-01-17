\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zirkelblatt}[2013/03/29 LaTeX class]

\LoadClass[a4paper,ngerman]{scrartcl}

\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel}
\RequirePackage{amsmath,amsthm,amssymb,amscd,color,graphicx}
\RequirePackage{environ}
\RequirePackage{framed}
\RequirePackage[protrusion=true,expansion=true]{microtype}
\RequirePackage{lmodern}
\RequirePackage{multicol}
\RequirePackage{hyperref}

\RequirePackage{geometry}
\geometry{tmargin=1.5cm,bmargin=0.8cm,lmargin=3cm,rmargin=3cm}

\setlength{\unitlength}{1cm}

\setlength\parskip{\medskipamount}
\setlength\parindent{0pt}

\newif\ifloesungen\loesungenfalse
\newif\ifpruefung\pruefungfalse

\newlength{\titleskip}
\setlength{\titleskip}{1.3em}
\renewcommand{\maketitle}[2]{%
  \ifloesungen\else\thispagestyle{empty}\fi%
\begin{picture}(0,0)
 \put(0,-1){  \vbox{  Mathesch\"ulerzirkel\\
   Universit\"at Augsburg\\
  Schuljahr 2013/2014\\
  #1 }}
 \put(13,-2){\includegraphics[scale=0.10]{cover} }
\end{picture} \vspace*{1.7cm}
  \begin{center}\Large \textbf{Zirkelzettel vom #2}
  \end{center}
  \vspace{\titleskip}}


\renewcommand*\theenumi{\alph{enumi}}
\renewcommand{\labelenumi}{\theenumi)}

\newlength{\aufgabenskip}
\setlength{\aufgabenskip}{1.4em}
\newcounter{aufgabennummer}
\newenvironment{aufgabe}[1]{
  \refstepcounter{aufgabennummer}
  \textbf{Aufgabe \theaufgabennummer.} \emph{#1} \par
}{\vspace{\aufgabenskip}}
\newenvironment{aufgabeE}[1]{\begin{aufgabe}{#1}\begin{enumerate}}{\end{enumerate}\end{aufgabe}}

\newenvironment{block}[1]{
  \begin{center}\textbf{#1}\end{center}
}{\vspace{\aufgabenskip}}

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

\newcommand{\NN}{\mathbb{N}}
\DeclareMathOperator{\mex}{mex}
\newcommand{\sur}[2]{\{ #1 \mathrel{|} #2 \}}

\definecolor{hicolor}{rgb}{.55,.12,.55}
\newcommand{\hil}[1]{\textcolor{hicolor}{#1}}

\definecolor{shadecolor}{rgb}{.93,.93,.93}

\newif\ifloesungen\loesungenfalse
\NewEnviron{loesung}{%
  \ifloesungen%
    \begin{shaded}\textbf{Lösung. }\BODY\end{shaded}%
  \fi%
}
