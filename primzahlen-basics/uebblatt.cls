\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uebblatt}[2013/03/29 LaTeX class]

\LoadClass[a4paper,ngerman]{scrartcl}

\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel}
\RequirePackage{amsmath,amsthm,amssymb,amscd,color,graphicx,environ}
\RequirePackage{mathtools}
\RequirePackage[protrusion=true,expansion=true]{microtype}
\RequirePackage{multicol}
\RequirePackage{xspace}
\RequirePackage{wrapfig}
\RequirePackage{hyperref}

\RequirePackage{lmodern}
%\RequirePackage[T1]{fontenc}
%\RequirePackage{libertine}

\RequirePackage{geometry}
\geometry{tmargin=1.5cm,bmargin=2cm,lmargin=2.1cm,rmargin=2.1cm}

\setlength\parskip{\medskipamount}
\setlength\parindent{0pt}

\newcounter{blattnummer}
\newlength{\titleskip}
\setlength{\titleskip}{0.7em}
\newenvironment{blatt}[1]{
  \clearpage
  \addtocounter{blattnummer}{1}
  \setcounter{aufgabennummer}{0}
  \thispagestyle{empty}
  Begabungsstützpunkt Mathematik \hfill Ingo Blechschmidt \\
  Schuljahr 2023/2024

  \begin{center}\Large \textbf{\textsf{#1}} \\[1em]
  \end{center}
  \vspace{\titleskip}
}{}

\renewcommand*\theenumi{\alph{enumi}}
\renewcommand{\labelenumi}{\theenumi)}

\newlength{\aufgabenskip}
\setlength{\aufgabenskip}{1.4em}
\newcounter{aufgabennummer}
\newenvironment{aufgabe}[1]{
  \refstepcounter{aufgabennummer}
  \textbf{Aufgabe \theaufgabennummer.} \emph{#1} \par
}{\par\vspace{\aufgabenskip}}

\newlength{\sternchenlength}
\settowidth{\sternchenlength}{$\star$ }
\newenvironment{aufgabe*}[1]{
  \addtocounter{aufgabennummer}{1}
  \hspace{-\sternchenlength}$\star$ \textbf{Aufgabe \theblattnummer.\theaufgabennummer.} \emph{#1} \par
}{\par\vspace{\aufgabenskip}}

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

\newcommand{\RR}{\mathbb{R}}
\newcommand{\CC}{\mathbb{C}}
\newcommand{\ZZ}{\mathbb{Z}}
\newcommand{\NN}{\mathbb{N}}
\newcommand{\PP}{\mathbb{P}}
\newcommand{\im}{\mathrm{i}}
\newcommand{\defeq}{\vcentcolon=}
