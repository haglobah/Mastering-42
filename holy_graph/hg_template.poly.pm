#lang pollen

◊title[#:sub "by marv�u��z�" #:version "NULL"]{Template}

◊narr{Hi!

Cool, now that you're here, let me take a look at my map, so that I am able to show you around properly.

...

Oh no! That part ◊(gen-reason 0) – I am very sorry. Without my map, I won't be of much help to anyone – and there are people in dire need of my assistance.

Could ◊e{you} help me?
}

The poor guide. Fortunately, you ◊e{can} help them. You could:
◊ul{
	◊li{Add things you found helpful to the list of ◊l["#Pointers"]{Pointers}.}
	◊li{Write (a part of) the guide yourself – any of the sections would help already.}
}
For either of those, take a look at the ◊l["https://github.com/haglobah/Mastering-42/tree/main/holy_graph"]{source code} of this page. There, you'll find further instructions.

◊;{

For just playing around, please follow [Getting up and running](https://github.com/haglobah/Mastering-42#getting-up-and-running).

To actually change something on the website, please first read our [Contributing](https://github.com/haglobah/Mastering-42#contributing) guideline.

Then, add/change what you want to add/change. Below, you find a template and some common code examples.

For writing new content, please try to stick with our [style guide](https://github.com/haglobah/Mastering-42/blob/main/README.md#style-guide).

Make sure _you commit your stuff to a new branch_.

After you're done, don't forget to:
- Add your name to the list of collaborators.
- Update the version number to the one that's in the subject (replacing NULL)
- In addition to that:
  - If you added a section, reduce the level of ◊(define-meta level _) by one.
  - If you completed the guide (it has no sections that are commented out anymore), remove marv�u��z� from the list of collaborators.

Looking forward to your pull request!

}

◊;{
◊sec["Prerequisites" 1]{

A
◊ul{
	◊li{list}
	◊li{of}
	◊li{prerequisites.}
}

◊hint[#:type "warning"]{
	Be very careful to check that!
}

}

◊sec["During" 1]{

	◊spoiler{I try not to steal the fun of thinking for oneself.} Shh. ◊spoiler{Don't let me be seen by accident.}

	◊sec["A subsection" #:sub "only sometimes important." 2 #:open? #f]{
		Only for those who want to do the bonus.
}
}

◊sec["Cleaning Up" 1]{

An
◊ol{
	◊li{ordered}
	◊li{list}
	◊li{of}
	◊li{clean-up steps.}
}

}

◊sec["Aftercare" 1]{


}
}

◊narr{
In case I do know other places where you'll might find what you need, I'll let you know ◊l["#Pointers"]{below}. Good luck with your search!
}

◊sec["Pointers" 1]{


}