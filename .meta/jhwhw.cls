%=====================================================================
% jhwhw.cls
% Provide jhwhw.cls class
%=====================================================================

%=====================================================================
% Identification
%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jhwhw}[2009/02/11 Justin Wilson's Homework Class]

\LoadClass[a4paper, 12pt]{article}

\RequirePackage{fancyhdr}
\RequirePackage[a4paper,width=160mm,top=25mm,bottom=25mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{empheq}
\RequirePackage{ifthen}


%=====================================================================
% Commands
%=====================================================================

  \setlength{\headheight}{15pt}
  \lhead{\@author}\chead{\@title}\rhead{\@date}
  \lfoot{}\cfoot{\thepage}\rfoot{}
  \pagestyle{fancy}

\ifx\pdfoutput\undefined                         %LaTeX
  \RequirePackage[ps2pdf,bookmarks=true]{hyperref}
  \hypersetup{ %
    pdfauthor   = {\@author},
    pdftitle    = {\@title},
    pdfcreator  = {LaTeX with hyperref package},
    pdfproducer = {dvips + ps2pdf}
  }
\else                                            %PDFLaTeX
  \RequirePackage[pdftex,bookmarks=true]{hyperref}
  \hypersetup{ %
    pdfauthor   = {\@author},
    pdftitle    = {\@title},
    pdfcreator  = {LaTeX with hyperref package},
    pdfproducer = {dvips + ps2pdf}
  }
\pdfadjustspacing=1
\fi

\newcounter{ProblemNum}
\newcounter{PartNum}[ProblemNum]
\newcounter{SubPartNum}[PartNum]

\renewcommand{\theProblemNum}{\arabic{ProblemNum}}
\renewcommand{\thePartNum}{\alph{PartNum}}
\renewcommand{\theSubPartNum}{\roman{SubPartNum}}

\newcommand*{\problem}[1]{\stepcounter{ProblemNum}
   \newpage\section*{Problem \theProblemNum. \; #1}}

\newcommand*{\solution}{\subsection*{Solution}}

\renewcommand*{\part}{\stepcounter{PartNum}
  \subsubsection*{Part (\thePartNum)}}
  
\newcommand*{\subpart}{\stepcounter{SubPartNum}\medskip\noindent\textbf{Subpart (\theSubPartNum)}\newline\indent}

\renewcommand{\theenumi}{(\alph{enumi})}
\renewcommand{\labelenumi}{\theenumi}
\renewcommand{\theenumii}{\roman{enumii}}

% CUSTOM DEFNS

\DeclarePairedDelimiter\abs{\lvert}{\rvert}
\DeclarePairedDelimiter\norm{\lVert}{\rVert}
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

\makeatletter
\let\oldabs\abs
\def\abs{\@ifstar{\oldabs}{\oldabs*}}
\let\oldnorm\norm
\def\norm{\@ifstar{\oldnorm}{\oldnorm*}}
\makeatother

\usepackage[most]{tcolorbox}

\tcbset{colback=white, colframe=black, arc=0pt,outer arc=0pt,
        highlight math style={enhanced, colframe=black,colback=white,boxsep=0pt}
        }

\let\boxm\tcboxmath

\newcommand*{\boxt}[1]{
  \begin{center}
    \boxm{
      \text{#1}
      }
  \end{center}}
  
\newcommand*{\der}[2]{
\dfrac{d#1}{d#2}
}

\newcommand*{\tosf}[1]{
\text{ (#1 s.f.)}
}

\newcommand*{\todp}[1]{
\text{ (#1 d.p.)}
}

\newcommand*{\nrm}[2]{
#1 - \dfrac{#2(#1)}{#2^\prime(#1)}
}
  
\newcommand*{\reject}[1]{
\qquad \text{(rej. #1)}
}

\numberwithin{equation}{ProblemNum}

\usepackage{amssymb}
\usepackage{amsmath}

\usepackage{tikz}
\usepackage{pgfplots}

\usetikzlibrary{arrows}
\usetikzlibrary{intersections}

\newcommand*{\case}[2]{
  \noindent\textbf{Case #1: #2}
  }
  
\pgfplotsset{compat=1.18}

\usetikzlibrary{decorations.markings}

\def\MarkLt{4pt}
\def\MarkSep{2pt}

\tikzset{
  TwoMarks/.style={
    postaction={decorate,
      decoration={
        markings,
        mark=at position #1 with
          {
              \begin{scope}[xslant=0.2]
              \draw[line width=\MarkSep,white,-] (0pt,-\MarkLt) -- (0pt,\MarkLt) ;
              \draw[-] (-0.5*\MarkSep,-\MarkLt) -- (-0.5*\MarkSep,\MarkLt) ;
              \draw[-] (0.5*\MarkSep,-\MarkLt) -- (0.5*\MarkSep,\MarkLt) ;
              \end{scope}
          }
       }
    }
  },
  TwoMarks/.default={0.5},
}

\usepackage{xcolor}
\colorlet{plotRed}{red!50}
\colorlet{plotBlue}{blue!50}