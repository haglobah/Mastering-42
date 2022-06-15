◊(require racket/list racket/string pollen/pagetree racket/path)
<!DOCTYPE html>
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
		<link rel="stylesheet" href="◊(find-link here 'fonts.css)">
		<link rel="stylesheet" href="◊(find-link here 'style.css)">
        <link rel="stylesheet" href="◊(find-link here 'pygments.css)">
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
                (->html `(div ((class "nav-node active"))
                               (a ((href "#")) "Home")
                         ,◊for/splice[[(category (in-list categories))]]{
                              ◊`(div ((class "nav-node"))
                                     (a ((href ,(find-link here category)))
                                        ,(get-folder-name category)))}))

                (->html ◊for/splice[[(category (in-list categories))]]{
                    ◊(if (compare-path category currentCategoryIndex)
                         `(div ((class ,(if (compare-path category here)
                                            "nav-node active"
                                            "nav-node")))
                               (a ((href ,(find-link here category)))
                                  ,(get-folder-name category))
                               ,◊for/splice[[(concept (in-list currentArticles))]]{
                                           ◊`(div ((class ,(if (compare-path concept here)
                                                          "nav-node active"
                                                          "nav-node")))
                                                  (a ((href ,(find-link here concept))) 
                                                     ,(or (select 'h1 concept) "Without Title")))})
                         `(div ((class "nav-node"))
                               (a ((href ,(find-link here category)))
                                  ,(get-folder-name category))))}))
            </div>
            <div class="content">
                ◊when/splice[(member here articles)]{
                <input type="checkbox" id="side-toggle">
                <label for="side-toggle">Toggle sidepanels</label>
                <!--<div class="meta">
                    <a href="◊(find-link here (get-pdf-path here))" class="pdf" target="_blank" rel="noopener noreferrer">Konzept herunterladen</a>
                </div>!-->}
                ◊(->html doc)
                <div class="adjacent-nav">
                    ◊(define prev-page (previous here))
                    ◊when/splice[#f ◊;{prev-page}]{
                    <div id="prev">← <a href=◊(string-append "Mastering-42/" (symbol->string prev-page))>◊(or (select 'h1 prev-page) "Without Title")</a></div>}
                    ◊(define next-page (next here))
					◊;(print here)
                    ◊when/splice[#f ◊;{next-page}]{
                    <div id="next"><a href=◊(string-append "" (symbol->string next-page))>◊(or (select 'h1 next-page) "Without Title")</a> →</div>}
                </div>
            </div>
        </main>
    <footer>
        <p class="copyright">
            ◊(get-year)
        </p>
        <div class="links">
            <a href="legal.html">Legal</a>
            <!-- <a href="impressum.html">Impressum</a> -->
        </div>
    </footer>
    <script src="◊(find-link here 'get-path.js)"></script>
</body>
</html>