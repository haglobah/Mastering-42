#lang pollen/mode racket/base
(require txexpr
         racket/date racket/path racket/list racket/string racket/file racket/runtime-path
         pollen/core pollen/setup pollen/tag pollen/decode pollen/misc/tutorial
         pollen/unstable/pygments
         sha
         dyoo-while-loop)
(provide title link b e heading sub quote-block sec requirements hint sec-hint ul ol li img code code-block side) ;"real" tag functions one might use
(provide find-link get-date get-year get-folder-name compare-path get-pdf-path pagetree-code root latex-replace) ;Utilities - for use in the templates

(module setup racket/base
	(provide (all-defined-out))
	(define poly-targets '(html ltx pdf))
  (define current-server-listen-ip "0.0.0.0"))

;Utilities - for use in the templates
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
        (string-replace 
          (path->string 
            (find-relative-path
              (string-append "ROOT/" from-folder-string)
              (string-append "ROOT/" to-folder-string))) 
          "\\" "/")))

(define (get-folder-name path)
	(let ([folder-of-path (if (equal? path #f) 
                            #f 
                            (path-only (if (symbol? path) 
                                           (symbol->string path) 
                                           path)))])
	     (if (equal? folder-of-path #f) 
           #f 
           (path->string (last (explode-path folder-of-path))))))

(define (compare-path path1 path2)
  (let  ([converted-path1 (if (symbol? path1) (symbol->string path1) path1)]
         [converted-path2 (if (symbol? path2) (symbol->string path2) path2)])
        (equal? (simplify-path converted-path1) (simplify-path converted-path2))))

(define (get-pdf-path path)
  (path->string (path-replace-extension (if (symbol? path) (symbol->string path) path) ".pdf")))

(define-syntax-rule (inc! n)
  (set! n (add1 n)))

(define generate-hash
  (let ([form-counter 0])
    (λ ()
      (inc! form-counter)
      (substring (bytes->hex-string (sha1 (string->bytes/utf-8 (number->string form-counter)))) 0 8))))

(define (wrap-forms node)
  (if (not (txexpr? node))
      node
      (let ([children (get-elements node)]
            [hash (generate-hash)])
           (if (or (member (get-tag node) '(p img ol ul)) 
                   (member (get-attrs node) '(((class "highlight")) ((class "sidepanel")))))
               (txexpr 'div '((class "form-container"))
                           `(,(attr-set node 'id hash)
                           ,@(generate-form hash)))
               (txexpr (get-tag node) (get-attrs node) (map wrap-forms children))))))

(define (generate-form hash)
        (define toggle-id (string-append "toggle_" hash))
        `(,(txexpr 'input `((type "checkbox") (id ,toggle-id)))
           ,(txexpr 'label `((for ,toggle-id)) '(""))
           ,(txexpr 'form '((class "sendEmail") (method "POST") (action "/message.php"))
                    `(,(txexpr 'textarea '((type "text") (class "comment") (name "comment") (placeholder "Kommentar")))
                      ,(txexpr 'input '((type "text") (class "email") (name "email") (placeholder "E-Mail Adresse")))
                      ,(txexpr 'input '((type "submit") (class "send") (value "Kommentieren")) empty)
                      ,(txexpr 'input `((type "hidden") (name "link") (value ,(string-append "#" hash))))))))

(define (is-inline? node)
  (and (txexpr? node) (member (get-tag node) '(br a b i code))))

(define (is-block? node)
  (and (txexpr? node) (not (is-inline? node))))

(define (p-contains-block? node)
  (if (txexpr? node)
      (if (equal? (get-tag node) 'p)
          (if (empty? (filter is-block? (get-elements node)))
              #f
              #t)
          #f)
      #f))

(define (unwrap-side-controls node)
  (define (is-controls? x) (and (txexpr? x) (equal? (attr-ref x 'class #f) "sidepanel-controls")))
  (define (replace-controls x)
    (if (is-controls? x)
            (get-elements x)
            `(,x)))
  (txexpr (get-tag node) (get-attrs node) (apply append (map replace-controls (get-elements node)))))

(define (clear-empty-ps node)
  (define (extract-blocks p)
    (if (p-contains-block? p)
      (get-elements p)
      `(,p)))
  (apply append (map extract-blocks (get-elements node))))

(define (process-nodes node)
  (cond 
    [(and (txexpr? node) (not (equal? (get-tag node) 'table))) ;Do not mess with code elements
     (let ([newElements (clear-empty-ps (unwrap-side-controls node))])
          (txexpr (get-tag node) (get-attrs node) (map process-nodes newElements)))]
    [else node]))

(define (root . elements)
  (case (current-poly-target)
    [(ltx pdf) (txexpr 'root empty elements)]
    [else (let ([output (decode-elements elements #:txexpr-elements-proc decode-paragraphs)])
               ;(wrap-forms (process-nodes (txexpr 'root empty output))))]))
			   (process-nodes (txexpr 'root empty output)))]))

;TAG FUNCTIONS
(define (link url . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\href{" ,url "}{" ,@elements "}"))]
	[else (txexpr 'a `((href ,url)) elements)]))

(define (b . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("{\\bf " ,@elements "}"))]
	[else (txexpr 'b empty elements)]))

(define (e . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\emph{" ,@elements "}"))]
	[else (txexpr 'i empty elements)]))

(define (quote-block #:author [author ""]. elements)
  (case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\emph{" ,@elements "}"))]
    [else (if (equal? author "")
			  (txexpr 'figure empty `(,(txexpr 'blockquote empty elements)))
			  (txexpr 'figure
			  		  empty
			  		  `(,(txexpr 'blockquote empty elements)
					    ,(txexpr 'figcaption empty `(,(txexpr 'p empty `(,author)))))))]))

(define (sub . elements)
  (case (current-poly-target)
    [(ltx pdf) (apply string-append '(" "))]
    [else (txexpr 'h4 '((class "subhead")) elements)]))

(define (title #:sub [subtitle ""] . elements)
  (case (current-poly-target)
    [(ltx pdf) (apply string-append `("{\\Huge " ,@elements "\\par} \\vspace{1.75em}"))]
	[else (txexpr 'div '((class "heading title")) 
		  `(,(txexpr 'h1 empty elements)
		    ,(sub subtitle)))]))

(define (heading level . elements)
  (if (> level 3)
      (error "Lasst uns keine zu kleinschrittigen Überschriften machen (nicht größer als 3)")
	    (case (current-poly-target)
        [(ltx pdf) (cond [(= level 1) (apply string-append `("\\par{\\LARGE " ,@elements "\\par} \\vspace{1.0em}"))]
                         [(= level 2) (apply string-append `("\\par{\\Large " ,@elements "\\par} \\vspace{0.7em}"))]
                         [(= level 3) (apply string-append `("\\par{\\large " ,@elements "\\par} \\vspace{0.5em}"))])]
		    [else (txexpr 'div '((class "heading"))
				  `(,(txexpr (string->symbol (string-append "h" (number->string (+ level 1))))
                      empty
                      elements)))])))

(define (sec title level #:sub [subtitle ""] . elements)
	(case (current-poly-target)
    [(ltx pdf) (cond [(= level 1) (apply string-append `("\\section{" ,title"}" ,@elements))]
                     [(= level 2) (apply string-append `("\\subsection{" ,title"}" ,@elements))]
                     [(= level 3) (apply string-append `("\\subsubsection{" ,title"}" ,@elements))])] ;include #:subs
		[else (txexpr 'details
			            '((open ""))
			            `(,(txexpr 'summary
					                    empty
				                     `(,(heading level
					                               title)
                            		   ,(if (equal? subtitle "")
                                    		"" 
                                    		(sub subtitle))))
				            ,(txexpr 'p empty `(,(car elements))) "\n" ,@(cdr elements)))]))

(define (requirements . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\emph{" ,@elements "}"))] ;include #:subs
		[else (txexpr 'details
			            '((class "requirements"))
			            `(,(txexpr 'summary
					                    empty
				                     `(,(heading 1 "Anforderungen")))
				            ,(txexpr 'p empty `(,(car elements))) "\n" ,@(cdr elements)))]))

(define (hint #:type [type "info"] . elements)
  (if (member type '("info"))
    (case (current-poly-target)
      [(ltx pdf) (apply string-append `(,@elements))]
      [else (txexpr 'div 
                    '((class "hint")) 
                    `(,(txexpr 'div
                               `((class ,type)) 
                               elements)))])
    (error "not a valid type for hint")))

(define (sec-hint title #:type [type "info"] . elements)
  (if (member type '("info"))
    (case (current-poly-target)
      [(ltx pdf) (apply string-append `(,@elements))]
      [else (txexpr 'div 
                    '((class "hint")) 
                    `(,(txexpr 'details
                               `((class ,type))
                               `(,(txexpr 'summary
                                          empty
                                          `(,title))
                                 ,(txexpr 'div empty `(,(car elements))) "\n" ,@(cdr elements)))
                      ))])
    (error "not a valid type for hint")))

(define (ul . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\begin{itemize}" ,@elements "\\end{itemize}"))]
		[else (txexpr 'ul empty elements)]))

(define (ol . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\begin{enumerate}" ,@elements "\\end{enumerate}"))]
		[else (txexpr 'ol empty elements)]))

(define (li . elements)
	(case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\item " ,@elements "\\par"))]
		[else (txexpr 'li empty elements)]))

(define (img url #:height [height 0] #:width [width 0] . caption)
  (case (current-poly-target)
    [(ltx pdf) (apply string-append `("\\par\\begin{figure}[h!]\\includegraphics[" 
                                    ,(cond 
                                      [(and (= height 0) (= width 0)) "width=1"] 
                                      [(= height 0) (string-append "width=" (number->string (* width 0.01)) "\\textwidth")]
                                      [(= width 0) (string-append "height=" (number->string (* height 0.01)) "\\textheight")]
                                      [else (string-append "width=" (number->string width) "\\textwidth, " "height=" (number->string height) "\\textheight")])
                                    "]{" ,url "}\\end{figure}"))]
    [else (txexpr 'img
                  `((src ,url) (style ,(string-append (if (= height 0)
                                                          "height: auto;"
                                                          (string-append "height: " (number->string height) "em;"))
                                                      (if (= width 0)
                                                          "width: auto;"
                                                          (string-append "width: " (number->string (* width 100)) "%"))))) empty)]))


(define (side label . elements)
  (case (current-poly-target)
    [(ltx pdf) (apply string-append '(" "))] ;TODO: Latex
    [else (inc! panel-counter)
          (txexpr 'div
                  '((class "sidepanel"))
                  `(,(txexpr 'div '((class "sidepanel-controls"))
                             `(,(txexpr 'input
                                      `((type "checkbox") (id ,(string-append "panel-"
                                                                              (number->string panel-counter)))) empty)
                              ,(txexpr 'label `((for ,(string-append "panel-"
                                                                    (number->string panel-counter)))) `(,label))))
                    ,(txexpr 'div '((class "sidepanel-content")) elements)))]))
(define panel-counter 0)

(define (code . elements)
  (case (current-poly-target)
    [(ltx pdf) (latex-escape (apply string-append elements))]
    [else (txexpr 'code empty elements)]))

(define (code-block language . lines)
  (define python "C:\\Users\\bente\\AppData\\Local\\Programs\\Python\\Python39\\python.exe")
  (define txcode (if (symbol? language)
                     (highlight language (apply string-append lines))
                     (highlight (string->symbol language) (apply string-append lines))))
  (case (current-poly-target)
    [(ltx pdf) (code->latex txcode)]
    [else txcode]))

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
    [(div) (case (attr-ref element 'class #f)
      [("highlight") (values "\\setmainfont{Source Code Pro}\\color{codecolor}\\begin{shaded*}" "\\end{shaded*}\\color{hsgrey}\\setmainfont{Overpass}")]
      [else (values "" "")])]
    [(span) (case (attr-ref element 'class #f)
      [("c" "ch" "cm" "cpf" "c1" "cs") (values "\\textcolor{comment}{" "}")]
      [("cp" "k" "kc" "kd" "kn" "kp" "kr" "nt" "ow") (values "\\textcolor{keyword}{" "}")]
      [("kt" "na" "nc" "nf") (values "\\textcolor{class}{" "}")]
      [("s" "sa" "sb" "sc" "dl" "sd" "s2" "se" "sh" "si" "sx" "s1" "ss") (values "\\textcolor{string}{" "}")]
      [("sr") (values "\\textcolor{regex}{" "}")]
      [("m" "mi" "md" "mf") (values "\\textcolor{number}{" "}")]
      [else (values "" "")])]
    [(table) (values "\\begin{xltabular}{\\textwidth}{rX}" "\\end{xltabular}")]
    [(tr) (values "" "\\\\")]
    [else (values "" "")]))

(define (codelines->table txcode) ;Dies ist eine Umformatierung, um den Code mit einer Latex-Tabelle darstellen zu können
  (define shake (λ (children)
    (filter (λ (child) (not (string? child))) children)))
  (define is-highlight? (λ (element) (and (txexpr? element) (equal? (attr-ref element 'class "") "highlight"))))
  (define is-tbody? (λ (element) (and (txexpr? element) (equal? 'tbody (get-tag element)))))
  (define is-source? (λ (element) (and (txexpr? element) (equal? "source" (attr-ref element 'class #f)))))
  (define tabularize (λ (body)
    (define (build-line text-elements)
      (set! table (append table (list (txexpr 'tr empty `(
                                                  ,(txexpr 'td empty `(,(string-append (number->string counter) "¶")))
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
  (call-with-values (λ () (splitf-txexpr 
                            (call-with-values (λ () (splitf-txexpr txcode is-highlight? shake))
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