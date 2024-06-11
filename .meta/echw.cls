%=====================================================================
% echw.cls
% Based on the echw class.
%=====================================================================

%=====================================================================
% Identification
%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{echw}[2024/06/12 Eytan Chong's Homework Class]

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

\numberwithin{equation}{ProblemNum}


%=====================================================================
% Packages
%=====================================================================

\usepackage{accents}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{bigstrut}
\usepackage{bm}
\usepackage{booktabs}
\usepackage{caption}
\usepackage{cases}
\usepackage{enumerate}
\usepackage{fbox}
\usepackage{float}
\usepackage{multirow}
\usepackage{tabularx}
\usepackage{systeme}
\usepackage[most]{tcolorbox}
\usepackage{varwidth}
\usepackage{xcolor}

\usepackage{tikz}
\usetikzlibrary{arrows, intersections, angles, quotes, calc, decorations.markings}

\usepackage{pgfplots}
\pgfplotsset{compat=1.18}
\usepgfplotslibrary{polar, fillbetween}

%=====================================================================
% Custom Definitions
%=====================================================================

% Absolute Value
\DeclarePairedDelimiter\abs{\lvert}{\rvert}

% Norm
\DeclarePairedDelimiter\norm{\lVert}{\rVert}

\makeatletter
\let\oldabs\abs
\def\abs{\@ifstar{\oldabs}{\oldabs*}}
\let\oldnorm\norm
\def\norm{\@ifstar{\oldnorm}{\oldnorm*}}
\makeatother

% Ceiling
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}

% Floor
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

% Differential Sign
\renewcommand{\d}[1]{\mathop{\mathrm{d}#1}}

% First Derivative
\newcommand*{\der}[2]{
\dfrac{\mathrm{d} #1}{\mathrm{d} #2}
}

% Higher-Order Derivatives
\newcommand*{\derm}[3]{
\dfrac{\mathrm{d}^{#3} #1}{\mathrm{d} {#2}^{#3}}
}

% To n Significant Figures
\newcommand*{\tosf}[1]{
\text{ (#1 s.f.)}
}

% To n Decimal Places
\newcommand*{\todp}[1]{
\text{ (#1 d.p.)}
}

% Newton-Raphson Method
\newcommand*{\nrm}[2]{
#1 - \dfrac{#2(#1)}{#2^\prime(#1)}
}

% Reject  
\newcommand*{\reject}[1]{
\qquad \text{(rej. \ensuremath{#1})}
}

% Inverse Function
\newcommand*{\inv}[1]{
#1^{-1}
}

% Range
\newcommand*{\ran}[1]{R_{#1}}

% Domain
\newcommand*{\dom}[1]{D_{#1}}

% Cases
\newcommand*{\case}[2]{
  \noindent\textbf{Case #1: #2}
}

% Real Part
\renewcommand{\Re}[1]{\mathfrak{Re}\left\{#1\right\}}

% Imaginary Part
\renewcommand{\Im}[1]{\mathfrak{Im}\left\{#1\right\}}

% 2D Coordinate
\newcommand*{\coord}[2]{\left(#1, #2\right)}

% 3D Coordinate
\newcommand*{\coordiii}[3]{\left(#1, #2, #3\right)}

% U-Substitution
\newcommand{\usub}[1]{\tag*{\colorbox{orange!20}{$\begin{aligned}#1\end{aligned}$}}}

% Evaluation of Integral
\newcommand{\eval}[3]{\left[#1\right]_{#2}^{#3}}

% Boldface Vectors
\renewcommand{\vec}[1]{\mathbf{#1}}

% 2D Column Vectors
\newcommand*{\cvecii}[2]{\begin{pmatrix} #1 \\ #2 \end{pmatrix}}

% 3D Column Vectors
\newcommand*{\cveciii}[3]{\begin{pmatrix} #1 \\ #2 \\ #3 \end{pmatrix}}

% Boldface Matrix
\newcommand{\matr}[1]{\bm{#1}}

% Area Operator
\DeclareMathOperator{\area}{Area}

% Volume Operator
\DeclareMathOperator{\volume}{Volume}

% Custom Colours
\colorlet{plotRed}{red!50}
\colorlet{plotBlue}{blue!50}
\colorlet{plotGreen}{green}
\colorlet{plotBlack}{black!50}

% Box for Solutions
\newcommand*{\boxt}[1]{
\begin{center}
	\fbox{\begin{varwidth}{\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}
		#1
	\end{varwidth}}
\end{center}
}

% Graphs - Two Marks
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