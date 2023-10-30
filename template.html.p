◊(require racket/list racket/string pollen/pagetree racket/path)
<!DOCTYPE html>
◊(define (mk-edit-link place)
	(string-append 
		"https://github.com/haglobah/Mastering-42/edit/main/" 
		(string-trim (symbol->string place) 
					 ".html" 
					 #:left? #f) 
		".poly.pm"))

◊(define title (select 'h1 doc))
◊(define description "Less pain, more gain. An opinionated strategy guide on how to get the most out of 42.")
◊(define url "https://haglobah.github.io/Mastering-42")
◊(define image (find-link here 'src/Images/42_logo.png))
◊(define icon (find-link here 'src/Images/white-42_logo.png))

<html>
    <head>
		<title>◊|title|</title>
		<meta name="description" content="◊|description|" >
		<link rel="icon" type="image/x-icon" href="◊|icon|">

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta property="og:locale" value="en_US">
		<meta property="og:type" value="website">
		<meta property="og:site_name" content="◊|title|" >
		<meta property="og:url" value="◊|url|" >
		<meta property="og:title" value="◊|title|" >
		<meta property="og:description" value="◊|description|" >
		<meta property="og:image:secure_url" content="◊|url|" />
		<meta property="og:image:type" content="image/jpg">
		<meta property="og:image:width" content="800">
		<meta property="og:image:height" content="1200">
		<meta property="og:image:alt" content="◊|title|" >

		<meta property="twitter:title" value="◊|title|" >
		<meta property="twitter:description" value="◊|description|" >
		<meta property="twitter:url" value="◊|url|" >
		<meta property="twitter:image" value="◊|image|" >
        <title>◊|title|</title> <!-- or ◊|here| -->
        ◊(define articles (flatten (filter-map children (flatten (map children (children 'pagetree-root))))))
        ◊(define rootSite (first (children 'pagetree-root)))
        ◊(define categories (children rootSite))
        ◊(define currentCategory (get-folder-name here))
		◊(define linkedHeadings 
			(let ([link-selection ('h2 . select-from-doc . doc)])
				(if (equal? link-selection #f)
					'()
					(filter string? link-selection))))
		<link rel="icon" type="image/x-icon" href="◊|icon|">
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
		<div class="flex items-center py-4 px-6 md:hidden">
		  <button type="button" id="hamburger-button" class="text-xl cursor-pointer">
		  	&#9776;
		  </button>
		</div>
		<div id="mobile-sidenav" class="fixed bg-white overflow-y-scroll hidden lg:hidden z-50 inset-0">
              ◊for/splice[[(category (in-list categories))]]{
                ◊(->html `(div ((class "relative p-6 "))
                           (a ((href ,(find-link here category))
						   	   (class ,(string-append 
										"pl-3 py-2 "
							   			(if (compare-path category here) "border-l-4 border-[var(--fst-clr)]" "border-l-4 border-[var(--bg-color)] hover:border-[var(--fst-clr-weak)] "))))
                              (span ((class "text-lg font-medium")) ,(get-folder-name category)))
                           ,◊for/splice[[(article (in-list (children category)))]]{
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
								)}))}
		</div>
        <div class="flex">
          <aside class="h-[88vh] sticky top-14 w-52 overflow-y-scroll hidden md:block">
              ◊for/splice[[(category (in-list categories))]]{
                ◊(->html `(div ((class "relative p-6 "))
                           (a ((href ,(find-link here category))
						   	   (class ,(string-append 
										"pl-3 py-2 "
							   			(if (compare-path category here) "border-l-4 border-[var(--fst-clr)]" "border-l-4 border-[var(--bg-color)] hover:border-[var(--fst-clr-weak)] "))))
                              (span ((class "text-lg font-medium")) ,(get-folder-name category)))
                           ,◊for/splice[[(article (in-list (children category)))]]{
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
								)}))}
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

