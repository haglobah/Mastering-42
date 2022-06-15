◊(require racket/file racket/system)

◊(define latex-source ◊string-append{
  \documentclass[a4paper,12pt]{article}

  \usepackage[ngerman]{babel}
  \usepackage{geometry}
  \usepackage{fancyhdr}       %Paket fuer selbstgestaltete Kopfzeilen
  \usepackage[table]{xcolor}
  \usepackage{framed}
  \usepackage{multicol}
  \usepackage{graphicx}
  \usepackage{xltabular}
  %\usepackage{ltablex}
  \usepackage{lmodern}
  \usepackage{fontspec}
  \usepackage[onehalfspacing]{setspace}
  \setmainfont{Overpass}

  \pagestyle{fancy}                %Seitenstil der mit fancyhdr benutzt werden muss

  \geometry{a4paper,right=2.5cm,left=2.5cm,top=1cm,bottom=6cm}
  \setlength{\headheight}{3.5cm}                %Groesse des Seitenkopfes
  \setlength{\headwidth}{1\textwidth}

  \renewcommand{\headrulewidth}{0cm}    %Strichdicke unter dem Seitenkopf
  \renewcommand{\arraystretch}{1.2}

  \usepackage{hyperref}
  \definecolor{hsblue}{HTML}{17a2b8}
  \definecolor{hsgrey}{HTML}{415365}

  \definecolor{shadecolor}{HTML}{1e1e1e}
  \definecolor{codecolor}{HTML}{d4d4d4}
  \definecolor{comment}{HTML}{6a9955}
  \definecolor{keyword}{HTML}{569cd6}
  \definecolor{class}{HTML}{9cdcfe}
  \definecolor{string}{HTML}{ce9178}
  \definecolor{regex}{HTML}{d16969}
  \definecolor{number}{HTML}{b5cea8}

  \begin{document}

  \shorthandoff{"}

  \color{hsgrey}

  %\tableofcontents
  {\chead{\textcolor{hsgrey}
  %{\flushright {\includegraphics[width=0.12\textwidth]{../source/images/hacker-school-logo-1.png}}
                 %\qquad \huge \bf Title \\
                 %{\textcolor{hsblue}{\rule[0.5em]{\textwidth}{1.2pt}}}
  %\\}
  }}

  {\cfoot{\textcolor{hsgrey}{\thepage}}}

  ◊(latex-replace (apply string-append (cdr doc)))
  \shorthandon{"}
  \end{document}})


◊(define working-directory
    (make-temporary-file "pollen-latex-work-~a" 'directory))
◊(define temp-ltx-path (build-path working-directory "temp.ltx"))
◊(display-to-file latex-source temp-ltx-path #:exists 'replace)
◊(define command (format "lualatex -output-directory ~a ~a"
  working-directory temp-ltx-path))
◊(unless (system command) (error "pdflatex: rendering error"))
◊(let ([pdf (file->bytes (build-path working-directory "temp.pdf"))])
   (delete-directory/files working-directory)
   pdf)
