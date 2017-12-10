\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zirkelblatt1718}[2013/03/29 LaTeX class]

\DeclareOption{twoside}{
  \PassOptionsToClass{\CurrentOption}{scrartcl}
}
\DeclareOption*{
  \ClassWarning{zirkelblatt1718}{Unbekannte Option '\CurrentOption'}
}

\ProcessOptions\relax

\LoadClass[a4paper,ngerman]{scrartcl}

\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel}
\RequirePackage{amsmath,amsthm,amssymb,amscd,color,graphicx}
\RequirePackage{environ}
\RequirePackage{framed}
\RequirePackage[protrusion=true,expansion=true]{microtype}
\RequirePackage{libertine}
\RequirePackage{multicol}
\RequirePackage{hyperref}

\addto\captionsngerman{\renewcommand\tablename{Tafel}}

\setlength{\unitlength}{1cm}

%\setlength\parskip{\medskipamount}
%\setlength\parindent{0pt}

\newlength{\titleskip}
\setlength{\titleskip}{1.3em}
\newcommand{\makeheader}[1]{%
  \thispagestyle{empty}%
  \begin{picture}(0,0)
   \put(0,-1){\vbox{%
     \noindent Mathesch\"ulerzirkel\\
     Universit\"at Augsburg\\
     Schuljahr 2017/2018\\
      #1}}
   \put(13,-2){\includegraphics[scale=0.10]{../cover}}
  \end{picture}%
  \vspace*{1.7cm}}
\renewcommand{\maketitle}[2]{%
  \makeheader{#1}
  \begin{center}\Large \textbf{Zirkelzettel vom #2}\end{center}
  \vspace{\titleskip}}
\newcommand{\maketitleCustom}[2]{%
  \makeheader{#1}
  \begin{center}\Large #2\end{center}
  \vspace{\titleskip}}

\renewcommand*\theenumi{\alph{enumi}}
\renewcommand{\labelenumi}{\theenumi)}

\newlength{\aufgabenskip}
\setlength{\aufgabenskip}{1.4em}
\newcounter{aufgabennummer}
\newenvironment{aufgabeUnshaded}[1]{
  \refstepcounter{aufgabennummer}
  \textbf{Aufgabe \theaufgabennummer.} \emph{#1} \par
}{\vspace{\aufgabenskip}}
\makeatletter
\NewEnviron{aufgabe}[1]{%
  \refstepcounter{aufgabennummer}%
  \begin{shaded}%
    \@startsection{paragraph}{4}{\z@}%
      {-0.00001ex}%
      {\medskipamount}%
      {}%
      {\textbf{Aufgabe \theaufgabennummer.} \emph{#1}}%
    %\noindent\subparagraph{\textbf{Aufgabe \theaufgabennummer.} \emph{#1}}
    \BODY%
  \end{shaded}%
}
\makeatother
\newcommand{\fixlistspacing}{\vspace{-\medskipamount}\vspace{-\itemsep}}

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

\newcommand{\NN}{\mathbb{N}}
\DeclareMathOperator{\mex}{mex}
\newcommand{\sur}[2]{\{ #1 \mathrel{|} #2 \}}

\definecolor{hicolor}{rgb}{.55,.12,.55}
\newcommand{\hil}[1]{\textcolor{hicolor}{#1}}

\definecolor{shadecolor}{rgb}{.93,.93,.93}
