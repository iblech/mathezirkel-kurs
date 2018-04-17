\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zirkelbrief1516}[2013/03/29 LaTeX class]

\DeclareOption{twoside}{
  \PassOptionsToClass{\CurrentOption}{scrartcl}
}
\DeclareOption*{
  \ClassWarning{zirkelbrief}{Unbekannte Option '\CurrentOption'}
}

\ProcessOptions\relax

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
\RequirePackage{xcolor}
% \RequirePackage{enumitem}

\addto\captionsngerman{\renewcommand\tablename{Tafel}}

\setlength{\unitlength}{1cm}
\setlength{\parindent}{0cm}

%\setlength\parskip{\medskipamount}
%\setlength\parindent{0pt}

\newcommand{\schuljahr}{}
\newcommand{\klasse}{}
\newcommand{\datum}{} %Wann der Brief verschickt wird
\newcommand{\titel}{}
\newcommand{\name}{}

\newlength{\titleskip}
\setlength{\titleskip}{1.3em}
\newcommand{\makeheader}{%
  \thispagestyle{empty}%
  \begin{picture}(0,0)
   \put(0,0){\vbox{%
     \noindent \begin{tabular}{ll} Mathesch\"ulerzirkel \hspace*{2cm} & Schuljahr \schuljahr \\
     Universit\"at Augsburg & Klassenstufen \klasse \\
     \name \end{tabular}
     }}
   \put(13,-1.8){\includegraphics[scale=0.10]{cover}}
  \end{picture}%
  \vspace*{1.7cm}
   \begin{center}\Large \textbf{\textsf{\titel \\
  \normalsize Korrespondenzbrief vom \datum}}\end{center}
  \vspace{\titleskip}
  }

\renewcommand*\theenumi{\alph{enumi}}
\renewcommand{\labelenumi}{(\theenumi)}

\definecolor{shadecolor}{rgb}{.93,.93,.93}
\newenvironment{shaded2}{%
  \def\FrameCommand{\fboxsep=\FrameSep \colorbox{shadecolor}}%
  \MakeFramed {\FrameRestore}}%
 {\endMakeFramed}


\theoremstyle{definition}
\newtheorem*{definition}{Definition}
\newtheorem*{rmk}{Bemerkung}
\newtheorem{aufg}{Aufgabe}
\newenvironment{aufgabe}[1][]
  {\begin{shaded}\vspace{-0.3cm}\begin{aufg}\emph{#1} \par\medskip}
  {\end{aufg}\vspace{-0.3cm}\end{shaded}}
\newtheorem*{beispiel}{Beispiel}
\theoremstyle{plain}
\newtheorem*{thm}{Satz}
\newenvironment{satz}
  {\begin{shaded}\vspace{-0.3cm}\begin{theorem}}
  {\end{theorem}\vspace{-0.3cm}\end{shaded}}

                  
% \newlength{\aufgabenskip}
% \setlength{\aufgabenskip}{1.4em}
% \newcounter{aufgabennummer}
% \definecolor{shadecolor}{rgb}{.93,.93,.93}
% \NewEnviron{aufgabe}[1][]{%
%   \refstepcounter{aufgabennummer}%
%   \begin{shaded}%
%     \noindent\textbf{Aufgabe \theaufgabennummer.} \emph{#1} \par\medskip
%     \noindent\BODY%
%   \end{shaded}%
% }


\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

\newcommand{\NN}{\mathbb{N}}
\newcommand{\N}{\mathbb{N}}
% \DeclareMathOperator{\mex}{mex}
% \newcommand{\sur}[2]{\{ #1 \mathrel{|} #2 \}}



