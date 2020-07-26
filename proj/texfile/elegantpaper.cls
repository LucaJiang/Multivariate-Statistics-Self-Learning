% Author: Dongsheng Deng
% Homepage: https://ddswhu.me/
% Email: elegantlatex2e@gmail.com
% Lastest Version: https://github.com/ElegantLaTeX/ElegantPaper

% --- Class structure: identification part
\ProvidesClass{elegantpaper}[2020/04/12 v0.09 ElegantLaTeX Paper class]
\NeedsTeXFormat{LaTeX2e} 

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}

\SetupKeyvalOptions{family=ELEGANT, prefix=ELEGANT@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{ELEGANT}{#1}}

\DeclareStringOption[en]{lang}
\DeclareVoidOption{cn}{\ekv{lang=cn}}
\DeclareVoidOption{en}{\ekv{lang=en}}

\DeclareStringOption[cm]{math}

\DeclareStringOption[numbers]{cite}
\DeclareVoidOption{numbers}{\ekv{cite=numbers}}
\DeclareVoidOption{authoryear}{\ekv{cite=authoryear}}
\DeclareVoidOption{super}{\ekv{cite=super}}

\DeclareStringOption[apalike]{bibstyle}

\DeclareStringOption[ctexfont]{chinesefont}
\DeclareVoidOption{ctexfont}{\ekv{chinesefont=ctexfont}}
\DeclareVoidOption{founder}{\ekv{chinesefont=founder}}
\DeclareVoidOption{nofont}{\ekv{chinesefont=nofont}}

\DeclareVoidOption{newtx}{\ekv{math=newtx}}
\DeclareVoidOption{mtpro2}{\ekv{math=mtpro2}}
\DeclareVoidOption{cm}{\ekv{math=cm}}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*\relax
\LoadClass{article}

\RequirePackage{hyperref}
\hypersetup{
  pdfborder={0 0 0},
  colorlinks=true,
  linkcolor={RubineRed},
  urlcolor={blue},
  filecolor={winered},
  citecolor={black},
  linktoc=all,
}
% settings for the hyperref and geometry
\RequirePackage[
  left=1in,
  right=1in,
  top=1in,
  bottom=0.9in,
  headheight=25pt,
  headsep=0pt]{geometry}
\setlength{\headsep}{15pt}

\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{indentfirst}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{bookmark}
% \RequirePackage{linegoal}
%\RequirePackage{xcolor}
\RequirePackage{algorithm}
\RequirePackage[noend]{algpseudocode}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{fancyvrb}
\RequirePackage{abstract}
\RequirePackage{hologo}

\linespread{1.35}
\graphicspath{{image/}{figure/}{fig/}{img/}}

% caption settings 
\RequirePackage[font=small,labelfont={bf}]{caption}
\captionsetup[table]{skip=3pt}
\captionsetup[figure]{skip=3pt}

% list/itemize/enumerate setting
\RequirePackage[shortlabels,inline]{enumitem}
\setlist{nolistsep}


% define the hyperref color 
\RequirePackage{xcolor}
\definecolor{winered}{rgb}{0.5,0,0}

\definecolor{lightgrey}{rgb}{0.95,0.95,0.95}
\definecolor{commentcolor}{RGB}{0,100,0}
\definecolor{frenchplum}{RGB}{190,20,83}

% add fancy header and footer
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[L]{\textcolor{black}{\leftmark}}
\fancyhead[R]{}
\fancyhead[C]{}
\fancyfoot[C]{\textcolor{black}{第\zhnumber{\thepage}页}}
% \quad 共\zhnumber{\pageref{LastPage}}页}}
\renewcommand{\headrule}{\color{black}\hrule width\textwidth}


% add the email cmd 
\newcommand\email[1]{\href{mailto:#1}{\nolinkurl{#1}}}

% font settings

\PassOptionsToPackage{no-math}{fontspec}
\ifdefstring{\ELEGANT@lang}{cn}{
  \ifXeTeX
    \ifdefstring{\ELEGANT@chinesefont}{founder}{
      \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
      \setCJKmainfont[BoldFont={FZHei-B01},ItalicFont={FZKai-Z03}]{FZShuSong-Z01}
      \setCJKsansfont[BoldFont={FZHei-B01},ItalicFont={FZHei-B01}]{FZHei-B01}
      \setCJKmonofont[BoldFont={FZHei-B01},ItalicFont={FZHei-B01}]{FZFangSong-Z02}
      \setCJKfamilyfont{zhsong}{FZShuSong-Z01}
      \setCJKfamilyfont{zhhei}{FZHei-B01}
      \setCJKfamilyfont{zhkai}{FZKai-Z03}
      \setCJKfamilyfont{zhfs}{FZFangSong-Z02}
      \newcommand*{\songti}{\CJKfamily{zhsong}}
      \newcommand*{\heiti}{\CJKfamily{zhhei}}
      \newcommand*{\kaishu}{\CJKfamily{zhkai}}
      \newcommand*{\fangsong}{\CJKfamily{zhfs}}}{\relax}
    
    \ifdefstring{\ELEGANT@chinesefont}{nofont}{
      \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}}{\relax}

    \ifdefstring{\ELEGANT@chinesefont}{ctexfont}{
      \RequirePackage[UTF8,scheme=plain]{ctex}}{\relax}
  \else
    \ifdefstring{\ELEGANT@chinesefont}{ctexfont}{
      \RequirePackage[UTF8,scheme=plain]{ctex}}{\relax}
  \fi
  \AfterEndPreamble{
    % \renewcommand{\itshape}{\kaishu}
    \setlength\parindent{2\ccwd}}}{\relax}

\ifcsname kaishu\endcsname
  \newcommand{\citshape}{\kaishu}
\else
  \newcommand{\citshape}{\itshape}
\fi
\ifcsname kaishu\endcsname
  \newcommand{\cnormal}{\kaishu}
\else
  \newcommand{\cnormal}{\normalfont}
\fi

\ifcsname fangsong\endcsname
  \newcommand{\cfs}{\fangsong}
\else
  \newcommand{\cfs}{\normalfont}
\fi

\RequirePackage{newtxtext}
\ifdefstring{\ELEGANT@math}{newtx}{
  \RequirePackage{newtxmath}
  \let\Bbbk\relax
  \RequirePackage{esint}
  %%% use yhmath pkg, uncomment following code
  % \let\oldwidering\widering
  % \let\widering\undefined
  % \RequirePackage{yhmath}
  % \let\widering\oldwidering

  %%% use esvect pkg, uncomment following code
  % \RequirePackage{esvect}

  \DeclareSymbolFont{CMlargesymbols}{OMX}{cmex}{m}{n}
  \let\sumop\relax\let\prodop\relax
  \DeclareMathSymbol{\sumop}{\mathop}{CMlargesymbols}{"50}
  \DeclareMathSymbol{\prodop}{\mathop}{CMlargesymbols}{"51}
}{\relax}

\RequirePackage{appendix}

\ifdefstring{\ELEGANT@lang}{cn}{
  \theoremstyle{plain}% default
  \newtheorem{theorem}{定理}[section] %
  \newtheorem{lemma}[theorem]{引理} %
  \newtheorem{proposition}[theorem]{命题} %
  \newtheorem*{corollary}{推论} %
  \theoremstyle{definition} %
  \newtheorem{definition}{定义}[section] %
  \newtheorem{conjecture}{猜想}[section] %
  \newtheorem{example}{例}[section] %
  \theoremstyle{remark} %
  \newtheorem*{remark}{\normalfont\bfseries 评论} %
  \newtheorem*{note}{\normalfont\bfseries 注} %
  \newtheorem{case}{\normalfont\bfseries 案例} %
  \renewcommand*{\proofname}{\normalfont\bfseries 证明} %
  \renewcommand\contentsname{目录}
  \renewcommand\refname{参考文献} %
  \renewcommand\figurename{图} %
  \renewcommand\tablename{表}%
  \newcommand\versiontext{版本：}%
  \newcommand\updatetext{日期：}%
  \renewcommand\abstractname{\large{摘\hspace{2em}要}}
  \setlength\parindent{2\ccwd}
  \renewcommand{\abstracttextfont}{\small\citshape\noindent\ignorespaces}
  % 新定义命令
  \newcommand{\keywords}[1]{\vskip2ex\par\noindent\normalfont{\bfseries 关键词: } #1}
  \newcommand\figref[1]{{\bfseries 图~\ref{#1}}}
  \newcommand\tabref[1]{{\bfseries 表~\ref{#1}}}
  \RequirePackage{gbt7714}
  \ifdefstring{\ELEGANT@cite}{authoryear}{
    \bibliographystyle{gbt7714-author-year}}{
    \bibliographystyle{gbt7714-numerical}}
  \ifdefstring{\ELEGANT@cite}{numbers}{
    \citestyle{numbers}}{\relax}
  \renewcommand{\appendixtocname}{附录}
  \renewcommand{\appendixpagename}{附录}}{\relax}

\ifdefstring{\ELEGANT@lang}{en}{
  \theoremstyle{plain}% default
  \newtheorem{theorem}{Theorem}[section] %
  \newtheorem{lemma}[theorem]{Lemma} %
  \newtheorem{proposition}[theorem]{Proposition} %
  \newtheorem*{corollary}{Corollary} %
  \theoremstyle{definition} %
  \newtheorem{definition}{Definition}[section] %
  \newtheorem{conjecture}{Conjecture}[section] %
  \newtheorem{example}{Example}[section] %
  \theoremstyle{remark} %
  \newtheorem*{remark}{Remark} %
  \newtheorem*{note}{Note} %
  \newtheorem{case}{Case} %
  \renewcommand*{\proofname}{\normalfont\bfseries Proof}%
  \newcommand\versiontext{\itshape Version: }%
  \newcommand\updatetext{\itshape Date: }%
  \setlength\parindent{2em}
  \renewcommand{\abstracttextfont}{\sffamily\small\noindent\ignorespaces}
  % newcommands defined in this template.
  \newcommand{\keywords}[1]{\vskip 2ex\par\noindent\normalfont{\bfseries Keywords: } #1}
  \newcommand\figref[1]{{\bfseries Figure~\ref{#1}}}
  \newcommand\tabref[1]{{\bfseries Table~\ref{#1}}}
  \RequirePackage[\ELEGANT@cite,sort&compress]{natbib}
  \bibliographystyle{\ELEGANT@bibstyle}}{\relax}

\setlength{\bibsep}{0.0pt}
\def\bibfont{\footnotesize}

\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}}
\BeforeBeginEnvironment{tabular}{\small}
\AfterEndEnvironment{tabular}{}

\AtBeginDocument{
  \setlength{\abovedisplayskip}{3pt}
  \setlength{\belowdisplayskip}{3pt}
  \RequirePackage[flushmargin]{footmisc}
  \setlength{\footnotesep}{6pt}}%12pt

\def\IfEmpty#1{%
  \edef\1{\the#1}
  \ifx\1\empty
}
\newtoks\version
\newtoks\institute

\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@0.1em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@ELEGANT@version\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\ELEGANT@version\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE\bfseries \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author\\[1ex]
      \end{tabular}\par}
      \the\institute%
\vskip 0.5ex%
\IfEmpty\version
\else 
{\small\normalfont\citshape\versiontext\the\version}
\fi
\ifx\@date\empty
\else
\vskip 0.1em%
 {\small\normalfont\citshape\updatetext\@date}%
\fi
  \end{center}%
  \par
}
  

%\RequirePackage[usenames,dvipsnames]{color} 
\RequirePackage{listings}
\renewcommand{\ttdefault}{cmtt}

\lstdefinestyle{estyle}{
  basicstyle=%
    \ttfamily
    \lst@ifdisplaystyle\footnotesize\fi
}
\lstset{basicstyle=\scriptsize\ttfamily,style=estyle}




\definecolor{mygreen}{RGB}{28,172,0} % color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}
\lstdefinestyle{matlab}
{language=matlab,%
    %basicstyle=\color{red},
    basicstyle=\ttfamily,
    breaklines=true,%
    morekeywords={matlab2tikz},
    keywordstyle=\color{blue},%
    morekeywords=[2]{1}, keywordstyle=[2]{\color{black}},
    identifierstyle=\color{black},%
    stringstyle=\color{mylilas},
    commentstyle=\color{mygreen},%
    showstringspaces=false,%without this there will be a symbol in the places where there is a space
%    numbers=left,%
%    numberstyle={\tiny \color{black}},% size of the numbers
%    numbersep=5pt, % this defines how far the numbers are from the text
    emph=[1]{for,end,break},emphstyle=[1]\color{red}, %some words to emphasise
    %emph=[2]{word1,word2}, emphstyle=[2]{style},    
}


\lstset{language=[LaTeX]TeX,
	texcsstyle=*\color{winered},
	numbers=none,
	breaklines=true,
	keywordstyle=\color{NavyBlue},
	frame=tlbr,framesep=4pt,framerule=0pt,
	commentstyle=\color{commentcolor},
	emph={elegantpaper,fontenc,fontspec,xeCJK,FiraMono,xunicode,newtxmath,figure,fig,image,img,table,itemize,enumerate,newtxtext,newtxtt,ctex,microtype,description,times,newtx,booktabs,tabular,PDFLaTeX,XeLaTeX,type1cm,BibTeX,cite,gbt7714,lang},
	emphstyle={\color{frenchplum}},
	morekeywords={DeclareSymbolFont,SetSymbolFont,toprule,midrule,bottomrule,institute,version,includegraphics,setmainfont,setsansfont,setmonofont ,setCJKmainfont,setCJKsansfont,setCJKmonofont,RequirePackage,figref,tabref,email,maketitle,keywords,zhdate,zhtoday},
	tabsize=2,
	backgroundcolor=\color{lightgrey}
}

\lstdefinestyle{R}{ 
  language=R,                     % the language of the code
  basicstyle=\ttfamily, % the size of the fonts that are used for the code
%  numbers=left,                   % where to put the line-numbers
%  numberstyle=\tiny\color{black}, % the style that is used for the line-numbers
%  stepnumber=1,                   % the step between two line-numbers. If it is 1, each line
                                  % will be numbered
%  numbersep=5pt,                  % how far the line-numbers are from the code
  backgroundcolor=\color{white},  % choose the background color. You must add \usepackage{color}
  showspaces=false,               % show spaces adding particular underscores
  showstringspaces=false,         % underline spaces within strings
  showtabs=false,                 % show tabs within strings adding particular underscores
  frame=single,                   % adds a frame around the code
  rulecolor=\color{black},        % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. commens (green here))
  tabsize=2,                      % sets default tabsize to 2 spaces
  captionpos=b,                   % sets the caption-position to bottom
  breaklines=true,                % sets automatic line breaking
  breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
  keywordstyle=\color{black},      % keyword style
  commentstyle=\color{YellowGreen},   % comment style
  stringstyle=\color{ForestGreen},      % string literal style
  frame=tlbr,framesep=4pt,framerule=0pt,
  backgroundcolor=\color{lightgrey}
} 



