#lang pollen

◊(require "../templates.rkt")
◊(define-meta level "5")

◊title[#:sub "by marv�u��z�" #:version "NULL"]{CPP}

◊(insert-intro (select 'level metas))

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
  - If you completed the guide (it has no sections that are commented out anymore), remove this section, ◊(insert-intro ...) and lines 3 & 4, as well as marv�u��z� from the list of collaborators.

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