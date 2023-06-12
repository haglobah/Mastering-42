#lang pollen/mode racket/base
(require txexpr
         racket/date
         racket/path
         racket/list
         racket/string
         racket/file
         pollen/setup
         pollen/decode)

; Tag functions
(provide title
         link
         l
         p
         b
         e
         irr
         heading
         h
         sub
         quote-block
         sec
         hint
         sec-hint
         ul
         ol
         il
         li
         ul-mark
         ol-mark
         img
         code
         c
         code-block
         hline
         spoiler
         table)

; Semantic markup for Mastering-42
(provide narr
         gen-reason)

; Utilities - for use in the templates
(provide find-link
         get-date
         get-year
         get-folder-name
         compare-path
         get-pdf-path
         pagetree-code
         root
         latex-replace) 

(module setup racket/base
  (provide (all-defined-out))
  (define poly-targets '(html ltx pdf))
  (define current-server-listen-ip "0.0.0.0"))

(define (latex-replace string)
  ;(define result (string-replace string "#" "\\#"))
  ;(set! result (string-replace result "&" "\\&"))
  ;(set! result (string-replace result "$" "\\$"))
  ;(set! result (string-replace result "%" "\\%"))
  ;(set! result (string-replace result "_" "\\_"))
  string)

(define (get-date)
  (date->string (current-date)))

(define (get-year)
  (number->string (date-year (current-date))))

(define (find-link from to)
  (let* ([from-folder (path-only (if (symbol? from) (symbol->string from) from))]
         [from-folder-string (if from-folder (path->string from-folder) "")]
         [to-folder-string (if (symbol? to) (symbol->string to) to)])
    (string-replace (path->string (find-relative-path (string-append "ROOT/" from-folder-string)
                                                      (string-append "ROOT/" to-folder-string)))
                    "\\"
                    "/")))

(define (get-folder-name path)
  (let ([folder-of-path
         (if (equal? path #f) #f (path-only (if (symbol? path) (symbol->string path) path)))])
    (if (equal? folder-of-path #f) #f (path->string (last (explode-path folder-of-path))))))

(define (compare-path path1 path2)
  (let ([converted-path1 (if (symbol? path1) (symbol->string path1) path1)]
        [converted-path2 (if (symbol? path2) (symbol->string path2) path2)])
    (equal? (simplify-path converted-path1) (simplify-path converted-path2))))

(define (get-pdf-path path)
  (path->string (path-replace-extension (if (symbol? path) (symbol->string path) path) ".pdf")))

(define-syntax-rule (inc! n) (set! n (add1 n)))

(define-syntax-rule (while cond expr ...)
  (let loop ()
    (when cond
      expr ...
      (loop))))

(define-syntax-rule (define-tag (TAG ... . REST) LTX HTML)
  (define (TAG ... . REST)
    (case (current-poly-target)
      [(ltx pdf) LTX]
      [else HTML])))

(define-tag (root . elements)
 `(root ,@elements)
 (begin 
 	(define with-paras
 			(decode `(root [(class "block max-w-prose px-4")] ,@elements)
					#:txexpr-elements-proc detect-paragraphs
					#:exclude-tags '(pre)))
	(define (add-classes-to-paras tx)
		(if (equal? (get-tag tx) 'p)
			(txexpr
				'p
				(cons '(class "my-2") (get-attrs tx))
				(get-elements tx))
			tx))
 	(decode with-paras #:txexpr-proc add-classes-to-paras)))

; Tag functions

(define-tag (link url
                  . elements)
            (apply string-append `("\\href{" ,url "}{" ,@elements "}"))
            `(a [(href ,url)
				 (class "text-[var(--fst-clr-weak)] hover:underline hover:decoration-2 hover:underline-offset-2 hover:decoration-[var(--fst-clr-weak)] hover:text-[var(--fst-clr)] ")]
				 ,@elements))
(define l link)

(define-tag (p . elements)
			(apply string-append `(,@elements))
			`(p [(class "my-2")]
				,@elements))

(define-tag (b . elements) (apply string-append `("\\bf{" ,@elements "}")) `(b ,@elements))

(define-tag (e . elements) (apply string-append `("\\emph{" ,@elements "}")) `(i ,@elements))

(define-tag (quote-block #:author [author ""] . elements)
            (apply string-append `("\\emph{" ,@elements "}"))
            (if (equal? author "")
                `(figure [(class "my-5 mx-10")]
						 (blockquote [(class "text-[var(--fst-clr)] text-sm font-fira-code")]
						 			 ,@elements))
                `(figure [(class "my-5 mx-10")] 
						 (blockquote [(class "text-[var(--fst-clr)] text-sm font-fira-code")]
						 			 ,@elements)
						 (figcaption [(class "italic text-sm text-right")]
						 			 (span [(class "before:content-['—'] before:left-8")]
									 	   ,author)))))

(define-tag (narr . elements)
            (apply string-append `("\\emph{" ,@elements "}"))
            `(div [(class "opacity-75 font-fira-code text-sm my-3")] ,@elements))

(define (splice-reason level)
  (cond
    [(equal? level "5") "is still uncharted territory"]
    [(equal? level "4") "has been ripped out"]
    [(equal? level "3") "has been washed out almost completely"]
    [(equal? level "2") "looks like it's had a hard time with termites"]
    [(equal? level "1") "has a coffee coffee stain on it"]))

(define-tag (gen-reason level)
            (splice-reason level)
            `(span ,(splice-reason level)))

(define-tag (irr . elements)
            (apply string-append `("\\emph{" ,@elements "}"))
            `(div [(class "opacity-30")] ,@elements))

(define-tag (hline)
			(apply string-append `("\\hrule"))
			`(hr [(class "mx-auto my-6 w-5/6 bg-[var(--snd-clr-weak)] border-t-2 border-[var(--snd-clr-weak)]")]))

(define spoiler
  (let ([spoiler-counter 0])
    (λ elements
      (case (current-poly-target)
        [(ltx pdf) (apply string-append '(" "))] ;TODO: Latex
        [else
         (inc! spoiler-counter)
         `(spoiler [(class "spoiler")]
                   (input [[type "checkbox"]
                           [id ,(string-append "spoiler-" (number->string spoiler-counter))]])
                   (label [(for ,(string-append "spoiler-" (number->string spoiler-counter))
                             )]
                          ,@elements))]))))

(define-tag (table . rows)
            (apply string-append `("here should come a table: " ,@rows))
            `(table ,@(map (λ (row)
                             `(tr ,@(map (λ (data) `(td ,data))
                                         (filter (λ (data) (not (equal? data "\n")))
                                                 (string-split row ",")))))
                           rows)))

(define-tag (sub . elements) (apply string-append '(" ")) `(h4 [(class "opacity-50 my-2 mx-4 inline-block")] ,@elements))

(define-tag (title #:sub [subtitle ""] #:version [version ""] . elements)
            (apply string-append `("{\\Huge " ,@elements "\\par} \\vspace{1.75em}"))
            `(div [(class "text-center mb-10")]
                  (h1 [(class "uppercase font-light text-3xl my-2 mx-2")] ,@elements)
                  ,(sub subtitle)
                  ,(if (equal? version "")
                       ""
                       `(h4 [(class "italic text-xs")] ,(string-append "written for version " version)))))

(define (parse-to-string element)
  (if (string? element) element (parse-to-string (append* element))))

(define (words->id . elements)
  ;(println elements)
  (if (string? (caar elements)) (caar elements) (parse-to-string (get-elements (caar elements)))))

(define (level->size lvl)
  	(case lvl
	  [(1) "text-2xl"]
	  [(2) "text-xl"]
	  [(3) "text-lg"]))

(define-tag
 (heading level . elements)
 (cond
   [(= level 1) (apply string-append `("\\par{\\LARGE " ,@elements "\\par} \\vspace{1.0em}"))]
   [(= level 2) (apply string-append `("\\par{\\Large " ,@elements "\\par} \\vspace{0.7em}"))]
   [(= level 3) (apply string-append `("\\par{\\large " ,@elements "\\par} \\vspace{0.5em}"))])
 (let ([current-id (words->id elements)])
   `(div [(class "heading inline-block mt-3 mb-1 border-b border-[var(--snd-clr-weak)]")]
         (,(string->symbol (string-append "h" (number->string (+ level 1))))
          [[id ,current-id] (class ,(string-append (level->size level) " uppercase font-light"))]
          (a [(class "heading-anchor px-1 text-xl font-normal opacity-0 transition-opacity hover:opacity-100 duration-300 text-[var(--fst-clr-weak)] hover:text-[var(--fst-clr)]")
		  	  [href ,(string-append "#" current-id)]] "#")
          ,@elements))))
(define h heading)

(define-tag
 (sec title level #:sub [subtitle ""] #:open? [open #t] . elements)
 (cond
   [(= level 1) (apply string-append `("\\section{" ,title "}" ,@elements))]
   [(= level 2) (apply string-append `("\\subsection{" ,title "}" ,@elements))]
   [(= level 3) (apply string-append `("\\subsubsection{" ,title "}" ,@elements))]) ;include #:subs
 `(details ,(if open '[[open ""]] empty)
           (summary [(class "border-b border-[var(--snd-clr-weak)] mb-3 cursor-pointer marker:text-[var(--snd-clr-weak)]")]
					,(heading level title) ,(if (equal? subtitle "") "" (sub subtitle)))
           (p ,@elements)))

(define-tag (hint #:type [type "info"] . elements)
            (apply string-append elements)
            (if (member type '("info" "warning" "error" "resolved"))
                `(div [(class "hint")] (div [(class ,type)] ,@elements))
                (error "not a valid type for hint")))

(define-tag (sec-hint title #:type [type "info"] . elements)
            (apply string-append elements)
            (if (member type '("info" "warning" "error" "resolved"))
                `(div [(class "hint")] (details [(class ,type)] (summary ,title) (div ,@elements)))
                (error "not a valid type for hint")))

(define-tag (ul . elements)
            (apply string-append `("\\begin{itemize}" ,@elements "\\end{itemize}"))
            `(ul ,@elements))

(define-tag (ol . elements)
            (apply string-append `("\\begin{itemize}" ,@elements "\\end{itemize}"))
            `(ol ,@elements))

(define-tag (il . elements)
            (apply string-append `("\\begin{itemize}" ,@elements "\\end{itemize}"))
            `(ul [(class "invisible-list")] ,@elements))

(define-tag (li . elements)
            (apply string-append `("\\begin{itemize}" ,@elements "\\end{itemize}"))
            `(li ,@elements))

(define-tag (ol-mark . elements)
            (apply string-append `("\\emph{" ,@elements "}"))
            `(span [(class "ol-mark")] ,@elements))

(define-tag (ul-mark . elements)
            (apply string-append `("\\emph{" ,@elements "}"))
            `(span [(class "ul-mark")] ,@elements))

(define-tag
 (img url #:height [height 0] #:width [width 0] . caption)
 (apply string-append
        `("\\par\\begin{figure}[h!]\\includegraphics["
          ,(cond
             [(and (= height 0) (= width 0)) "width=1"]
             [(= height 0) (string-append "width=" (number->string (* width 0.01)) "\\textwidth")]
             [(= width 0) (string-append "height=" (number->string (* height 0.01)) "\\textheight")]
             [else
              (string-append "width="
                             (number->string width)
                             "\\textwidth, "
                             "height="
                             (number->string height)
                             "\\textheight")])
          "]{"
          ,url
          "}\\end{figure}"))
 `(figure
   [(class "img")]
   (img [[src ,url]
         [style
          ,(string-append
            (if (= height 0) "height: auto;" (string-append "height: " (number->string height) "em;"))
            (if (= width 0)
                "width: auto;"
                (string-append "width: " (number->string (* width 100)) "%")))]])
   (figcaption [(class "imgcaption")] ,@caption)))

(define note
  (let ([note-counter 0])
    (λ (label . elements)
      (case (current-poly-target)
        [(ltx pdf) (apply string-append '(" "))] ;TODO: Latex
        [else
         (inc! note-counter)
         `(div [(class "footnote")]
               (div [(class "footnote-controls")]
                    (input [[type "checkbox"]
                            [id ,(string-append "note-" (number->string note-counter))]])
                    (label [(for ,(string-append "note-" (number->string note-counter))
                              )]
                           ,@elements))
               (div [(class "footnote-content")] ,@elements))]))))

(define-tag (code . elements) (latex-escape (apply string-append elements)) `(code ,@elements))
(define c code)

(define-tag (code-block language #:filename [filename ""] #:nums? [nums #t] . lines)
            "Here should be code."
            `(div [(class "code-block")]
                  (span [(class "filename")] ,filename)
                  (pre (code ((class ,(format "language-~a" language))) ,@lines))))

#;(define (code-block language #:filename [filename ""] #:nums? [nums #t] . lines)
    (define txcode
      (if (symbol? language)
          (highlight language #:line-numbers? nums (apply string-append lines))
          (highlight (string->symbol language) #:line-numbers? nums (apply string-append lines))))
    (case (current-poly-target)
      [(ltx pdf) (code->latex txcode)]
      [else `(div [(class "code-block")] (span [(class "filename")] ,filename) ,txcode)]))

;Helper functions - only for those who write code in here (-> pollen.rkt)
(define (latex-escape string)
  (define result (string-replace string "#" "\\#"))
  (set! result (string-replace result "&" "\\&"))
  (set! result (string-replace result "¶" "&"))
  (set! result (string-replace result "%" "\\%"))
  (set! result (string-replace result "$" "\\$"))
  (set! result (string-replace result "_" "\\_"))
  (set! result (string-replace result "{" "\\{"))
  (set! result (string-replace result "}" "\\}"))
  (set! result (string-replace result "\n" "\\\\"))
  (set! result (string-replace result "    " "\t"))
  (set! result (string-replace result " " "\\ "))
  (set! result (string-replace result "\t" "\\hspace*{2.4em}"))
  result)

(define (element->wraptex element) ;Hier sind die Latex-Befehle für die einzelnen Tags definiert
  (case (get-tag element)
    [(div)
     (case (attr-ref element 'class #f)
       [("highlight")
        (values "\\setmainfont{Source Code Pro}\\color{codecolor}\\begin{shaded*}"
                "\\end{shaded*}\\color{hsgrey}\\setmainfont{Overpass}")]
       [else (values "" "")])]
    [(span)
     (case (attr-ref element 'class #f)
       [("c" "ch" "cm" "cpf" "c1" "cs") (values "\\textcolor{comment}{" "}")]
       [("cp" "k" "kc" "kd" "kn" "kp" "kr" "nt" "ow") (values "\\textcolor{keyword}{" "}")]
       [("kt" "na" "nc" "nf") (values "\\textcolor{class}{" "}")]
       [("s" "sa" "sb" "sc" "dl" "sd" "s2" "se" "sh" "si" "sx" "s1" "ss")
        (values "\\textcolor{string}{" "}")]
       [("sr") (values "\\textcolor{regex}{" "}")]
       [("m" "mi" "md" "mf") (values "\\textcolor{number}{" "}")]
       [else (values "" "")])]
    [(table) (values "\\begin{xltabular}{\\textwidth}{rX}" "\\end{xltabular}")]
    [(tr) (values "" "\\\\")]
    [else (values "" "")]))

(define (codelines->table
         txcode) ;Dies ist eine Umformatierung, um den Code mit einer Latex-Tabelle darstellen zu können
  (define shake (λ (children) (filter (λ (child) (not (string? child))) children)))
  (define is-highlight?
    (λ (element) (and (txexpr? element) (equal? (attr-ref element 'class "") "highlight"))))
  (define is-tbody? (λ (element) (and (txexpr? element) (equal? 'tbody (get-tag element)))))
  (define is-source?
    (λ (element) (and (txexpr? element) (equal? "source" (attr-ref element 'class #f)))))
  (define tabularize
    (λ (body)
      (define (build-line text-elements)
        (set! table
              (append
               table
               (list (txexpr 'tr
                             empty
                             `(,(txexpr 'td empty `(,(string-append (number->string counter) "¶")))
                               ,(txexpr 'td empty text-elements))))))
        (inc! counter))

      (define code (get-elements (first (get-elements (findf-txexpr body is-source?)))))
      (define table (list))
      (define counter 1)
      (define linebreak (λ (s) (and (string? s) (string-contains? s "\n"))))
      (define break-pos (index-where code linebreak))
      (define break-text null)
      (while (not (equal? break-pos #f))
             (set! break-text (string-trim (list-ref code break-pos) " " #:right? #f #:repeat? #t))
             (build-line (take code break-pos))
             (set! break-text (string-replace break-text "\n" "" #:all? #f))
             (while (string-contains? break-text "\n")
                    (build-line empty)
                    (set! break-text (string-replace break-text "\n" "" #:all? #f)))
             (set! code (append (list break-text) (drop code (+ break-pos 1))))
             (set! break-pos (index-where code linebreak)))
      (build-line code)
      (txexpr 'tbody empty table)))
  (call-with-values
   (λ ()
     (splitf-txexpr (call-with-values (λ () (splitf-txexpr txcode is-highlight? shake))
                                      (λ (newexpr replaced) newexpr))
                    is-tbody?
                    tabularize))
   (λ (newexpr replaced) newexpr)))

(define (code->latex txcode)
  (define (exchange codepart)
    (if (string? codepart)
        (latex-escape codepart)
        (call-with-values
         (λ () (element->wraptex codepart))
         (λ (opening closing)
           (flatten (list opening (map exchange (get-elements codepart)) closing))))))
  (define result (apply string-append (exchange (codelines->table txcode))))
  result)

(define (pagetree-code)
  (define content (file->string "index.ptree"))
  (code-block 'pollen content))
