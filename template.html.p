◊(require racket/list racket/string pollen/pagetree racket/path)
<!DOCTYPE html>
◊(define (mk-edit-link place)
	(string-append 
		"https://github.com/haglobah/Mastering-42/edit/main/" 
		(string-trim (symbol->string place) 
					 ".html" 
					 #:left? #f) 
		".poly.pm"))
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta property="og:title" value="◊(select 'h1 doc)">
        <meta property="og:image" value="◊(find-link here 'src/Images/42_logo.png)">
        <title>◊(select 'h1 doc)</title> <!-- or ◊|here| -->
        ◊(define articles (flatten (filter-map children (flatten (map children (children 'pagetree-root))))))
        ◊(define rootSite (first (children 'pagetree-root)))
        ◊(define categories (children rootSite))
        ◊(define currentCategory (get-folder-name here))
        ◊(define currentCategoryIndex (unless (equal? currentCategory #f) (string-append currentCategory "/index.html")))
        ◊(define currentArticles (if (equal? currentCategory #f)
                                     #f
                                     (children (string->symbol currentCategoryIndex))))
		◊(define linkedHeadings 
			(let ([link-selection ('h2 . select-from-doc . doc)])
				(if (equal? link-selection #f)
					'()
					(filter string? link-selection))))
		<link rel="icon" type="image/x-icon" href="/src/Images/white-42_logo.png">
		<link rel="stylesheet" href="◊(find-link here 'fonts.css)">
		<link rel="stylesheet" href="◊(find-link here 'style.css)">
		<link rel="stylesheet" 
			  href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/night-owl.min.css">
		<script src="/highlight.min.js"></script>
		<script>
		hljs.highlightAll();
		</script>
    </head>
    <body>
        <header>
            <nav>
                <a class="nav-logo" href="◊(find-link here rootSite)">
					<!--<h3>Mastering</h3> -->
                    <img src="◊(find-link here 'src/Images/42_logo_big.jpg)" alt="Mastering 42">
                </a>
                <input type="checkbox" name="hamburger-button" id="nav-toggle">
                <div class="nav-list">
                    ◊for/splice[[(category (in-list categories))]]{
                    ◊(if (equal? (get-folder-name category) currentCategory)
                         (->html `(a ((href ,(find-link here category))
                                      (class "nav-item active")) ,(get-folder-name category)))
                         (->html `(a ((href ,(find-link here category))
                                      (class "nav-item")) ,(get-folder-name category))))}
                </div>
                <label for="nav-toggle"></label>
            </nav>
        </header>
        <main>
            <div class="sidenav">
           ◊(if (equal? currentCategory #f)
              ""
              (->html ◊for/splice[[(category (in-list categories))]]{
                ◊(if (compare-path category currentCategoryIndex)
                     `(div ((class ,(if (compare-path category here)
                                        "nav-node active"
                                        "nav-node")))
                           (a ((href ,(find-link here category)))
                              (span ((class "category")) ,(get-folder-name category)))
                           ,◊for/splice[[(article (in-list currentArticles))]]{
                              ◊`(div ((class ,(string-append 
                                                "nav-node "
                                                (if (compare-path article here) "active " "")
                                                (cond
                                                  [(equal? (select 'level (get-metas article)) "5") "stub "]
                                                  [(member (select 'level (get-metas article)) 
                                                                   '("4" "3" "2" "1"))
                                                   "in-progress "]
                                                  [else ""]))))
                                     (a ((href ,(find-link here article))) 
                                        ,(or (select 'h1 article) "Without Title"))
									 ,◊for/splice[[(link (in-list linkedHeadings))]]{
										◊(if (compare-path article here)
									         ◊`(div ((class "nav-node"))
										       (a ((href ,(string-append "#" link))) ,link))
										     "")}
								)})
                     `(div ((class "nav-node"))))}))
            </div>
            <div class="content">
                ◊when/splice[(and #false (member here articles))]{
                <input type="checkbox" id="side-toggle">
                <label for="side-toggle">Toggle sidepanels</label>
                <!--<div class="meta">
                    <a href="◊(find-link here (get-pdf-path here))" class="pdf" target="_blank" rel="noopener noreferrer">Konzept herunterladen</a>
                </div>!-->}
                ◊(->html doc)
                <div class="adjacent-nav">
                    ◊(define prev-page (previous here))
                    ◊when/splice[prev-page]{
                    <div id="prev">← <a href=◊(string-append "/Mastering-42/" (symbol->string prev-page))>◊(or (select 'h1 prev-page) "Without Title")</a></div>}
                    ◊(define next-page (next here))
					◊;(print here)
					<div id="contrib">Found something to improve? Edit this page on <a href=◊(mk-edit-link here) target="_blank"> Github</a>!</div>
                    ◊when/splice[next-page]{
                    <div id="next"><a href=◊(string-append "/Mastering-42/" (symbol->string next-page))>◊(or (select 'h1 next-page) "Without Title")</a> →</div>}
                </div>
            </div>
        </main>
    <footer>
        <p class="copyright">
            ◊(get-year)
        </p>
        <div class="links">
            <a href="legal.html">Legal</a>
        </div>
    </footer>
</body>
</html>

