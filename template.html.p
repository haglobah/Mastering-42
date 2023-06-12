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
		<link rel="icon" type="image/x-icon" href="◊(find-link here 'src/Images/white-42_logo.png)">
		<link rel="stylesheet" href="◊(find-link here 'fonts.css)">
		<link rel="stylesheet" href="◊(find-link here 'style.css)">
		<link rel="stylesheet" 
			  href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/night-owl.min.css">
		<script src="https://cdn.tailwindcss.com"></script>
		<script src="◊(find-link here 'highlight.min.js)"></script>
		<script>
		hljs.highlightAll();
		</script>
		<script src="◊(find-link here 'main.js)"></script>
    </head>
    <body>
		<div class="top-0 w-full">
		  <div class="py-4 lg:px-8 mx-4 lg:mx-0">
		  	<div class="relative flex items-center justify-between">
			  <a class="ml-10" href="◊(find-link here rootSite)">
				<img class="h-8" src="◊(find-link here 'src/Images/42_logo.png)" alt="Mastering 42">
			  </a>
			  ◊; <input type="checkbox" name="hamburger-button" id="nav-toggle">
			  <div class="flex flex-wrap justify-end">
				◊for/splice[[(category (in-list categories))]]{
				◊(if (equal? (get-folder-name category) currentCategory)
						(->html `(a ((href ,(find-link here category))
									(class "underline decoration-[var(--fst-clr-weak)] decoration-[3px] underline-offset-[5px] mx-4 my-1 hover:decoration-[var(--fst-clr)] hover:decoration-[3px] hover:underline-offset-[5px]"))
									,(get-folder-name category)))
						(->html `(a ((href ,(find-link here category))
									(class "mx-4 my-1 hover:underline hover:decoration-[var(--fst-clr)] hover:decoration-[3px] hover:underline-offset-[5px]"))
									,(get-folder-name category))))}
			  </div>
			  ◊; <label for="nav-toggle"></label>
			</div>
		  </div>
		</div>
		<div class="flex items-center p-4 md:hidden">
		  <button type="button" id="hamburger-button" class="text-xl cursor-pointer">
		  	&#9776;
		  </button>
		  <ol class="flex text-sm ml-4">
		  	◊; <li>
			◊;   ◊|currentCategory|
		  	◊; </li>
		  	<li>
			  ◊(->html `(a [(href ,(find-link here here))] ,(find-link here here)))
		  	</li>
		  </ol>
		</div>
		<div id="mobile-sidenav" class="fixed overflow-y-auto hidden lg:hidden z-50 inset-0">
		  <div class="relative bg-white w-80 p-6 ">
			◊(if (equal? currentCategory #f)
              ""
              (->html ◊for/splice[[(category (in-list categories))]]{
                ◊(if (compare-path category currentCategoryIndex)
                     `(div ((class ""))
                           (a ((href ,(find-link here category))
						   	   (class ,(string-append 
										"pl-3 py-2 "
							   			(if (compare-path category here) "border-l-4 border-[var(--fst-clr)]" "border-l-4 border-[var(--bg-color)] hover:border-[var(--fst-clr-weak)] "))))
                              (span ((class "text-lg font-medium")) ,(get-folder-name category)))
                           ,◊for/splice[[(article (in-list currentArticles))]]{
                              ◊`(div ((class ,(string-append 
                                                "pl-7 py-1.5 "
                                                (if (compare-path article here) "border-l-4 border-[var(--fst-clr)] " "border-l-4 border-[var(--bg-color)] hover:border-[var(--fst-clr-weak)] ")
												(cond
													[(equal? (select 'level (get-metas article)) "5") " opacity-50 "]
													[(member (select 'level (get-metas article)) 
															 '("4" "3" "2" "1")) " opacity-75 "]
													[else ""]))))
                                     (a ((href ,(find-link here article)) (class ,(if (compare-path article here) "text-[var(--fst-clr-weak)] text-lg hover:text-[var(--fst-clr)]" "")))
                                        ,(or (select 'h1 article) "Without Title"))
									 ,◊for/splice[[(link (in-list linkedHeadings))]]{
										◊(if (compare-path article here)
									         ◊`(div ((class "pl-3 py-2 text-sm hover:text-[var(--fst-clr-weak)] hover:no-underline"))
										       (a ((href ,(string-append "#" link))) ,link))
										     "")}
								)})
                     `(div ((class "nav-node"))))}))
		  </div>
		</div>
        <div class="flex">
          <aside class="h-[88vh] sticky top-14 w-52 overflow-y-scroll hidden md:block">
           ◊(if (equal? currentCategory #f)
              ""
              (->html ◊for/splice[[(category (in-list categories))]]{
                ◊(if (compare-path category currentCategoryIndex)
                     `(div ((class ""))
                           (a ((href ,(find-link here category))
						   	   (class ,(string-append 
										"pl-3 py-2 "
							   			(if (compare-path category here) "border-l-4 border-[var(--fst-clr)]" "border-l-4 border-[var(--bg-color)] hover:border-[var(--fst-clr-weak)] "))))
                              (span ((class "text-lg font-medium")) ,(get-folder-name category)))
                           ,◊for/splice[[(article (in-list currentArticles))]]{
                              ◊`(div ((class ,(string-append 
                                                "pl-7 py-1.5 "
                                                (if (compare-path article here) "border-l-4 border-[var(--fst-clr)] " "border-l-4 border-[var(--bg-color)] hover:border-[var(--fst-clr-weak)] ")
												(cond
													[(equal? (select 'level (get-metas article)) "5") " opacity-50 "]
													[(member (select 'level (get-metas article)) 
															 '("4" "3" "2" "1")) " opacity-75 "]
													[else ""]))))
                                     (a ((href ,(find-link here article)) (class ,(if (compare-path article here) "text-[var(--fst-clr-weak)] text-lg hover:text-[var(--fst-clr)]" "")))
                                        ,(or (select 'h1 article) "Without Title"))
									 ,◊for/splice[[(link (in-list linkedHeadings))]]{
										◊(if (compare-path article here)
									         ◊`(div ((class "pl-3 py-2 text-sm hover:text-[var(--fst-clr-weak)] hover:no-underline"))
										       (a ((href ,(string-append "#" link))) ,link))
										     "")}
								)})
                     `(div ((class "nav-node"))))}))
            </aside>
            <main class="mx-auto">
                ◊(->html doc)
                <div class="flex justify-around items-center pt-8 pb-4">
                    ◊(define prev-page (previous here))
                    ◊when/splice[prev-page]{
					  <div>
						<a class="text-sm text-[var(--fst-clr-weak)] hover:text-[var(--fst-clr)]"
						   href=◊(string-append "/Mastering-42/" (symbol->string prev-page))>
							◊(string-append "← " (or (select 'h1 prev-page) "Without Title"))
						</a>
					  </div>
					}

					<div>
					  <p class="text-xs italic opacity-75 font-light">
					  	Found something to improve? Edit this page on
							<a class="text-[var(--fst-clr-weak)] hover:text-[var(--fst-clr)] hover:underline hover:decoration-2 hover:underline-offset-2 hover:decoration-[var(--fst-clr-weak)]"
							   href=◊(mk-edit-link here) target="_blank"> Github</a>!</p>
					</div>

                    ◊(define next-page (next here))
					◊;(print here)
                    ◊when/splice[next-page]{
					  <div>
						<a class="text-sm text-[var(--fst-clr-weak)] hover:text-[var(--fst-clr)]"
							href=◊(string-append "/Mastering-42/" (symbol->string next-page))>
							◊(string-append (or (select 'h1 next-page) "Without Title") " →")
						</a>
					  </div>
					}
                </div>
            </main>
        </div>
    <footer class="text-center py-10 bg-[var(--fst-clr-bg)]">
        <p>◊(get-year)</p>
        <div class="flex justify-center links">
            <a href="legal.html" class="hover:underline hover:decoration-2 hover:underline-offset-2 hover:decoration-[var(--fst-clr-weak)] hover:text-[var(--fst-clr)]">Legal</a>
        </div>
    </footer>
</body>
</html>

