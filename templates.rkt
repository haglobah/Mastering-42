#lang pollen/mode racket/base

(require "pollen.rkt")

(provide (all-defined-out))

(define (div . elements)
    `(div ,@elements))

(define (insert-intro level)
  ◊div{
  ◊narr{Hi!

Cool, now that you're here, let me take a look at my map, so that I am able to show you around properly.

...

◊p{Oh no! That part ◊(gen-reason level) – I am very sorry. Without my map, I won't be of much help to anyone – and there are people in dire need of my assistance.}

...

Could ◊e{you} help me?
}

The poor guide. Fortunately, you ◊e{can} help them. You could:
◊ul{
	◊li{Add things you found helpful to the list of ◊l["#Pointers"]{Pointers}.}
	◊li{Write (a part of) the guide yourself – any of the sections would help already.}
}
For either of those, take a look at the ◊l["https://github.com/haglobah/Mastering-42/tree/main/holy_graph"]{source code} of this page. There, you'll find further instructions.
  }
)