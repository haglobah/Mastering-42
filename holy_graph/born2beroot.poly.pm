#lang pollen

◊title[#:sub "by bhagenlo" #:version "1"]{Born2beroot}

◊narr{My God. Am I sorry for you that you have to do this. But anyway, let's start.}

Depending on your previous knowledge, you're likely to feel quite lost after reading the subject for the first time. Well, unfortunately, that is how many of us felt.

And it might be because the subject barely mentions reasons for doing particular things, or because you'd have to google every single bullet point mentioned in the subject for solving it 'properly' on your own.

In my view, there are two sensible ways to approach this project. You either:
◊ol{
	◊li{Read a lot about Linux, its file system structure, how the OS works, and please, ask at least some knowledgeable people whenever you feel stuck. This is a lot, and it takes some time to finally know what all this is doing. 
	It's so much I'd even advise you to create Anki Flashcards on the way.}


	or:
	◊li{Get yourself some walkthrough that works, as well as an extensive (◊e{self-written}) 'cheat sheet' for your eval, so that you at least can accomplish what you're asked to do.}
}

◊sec["Prerequisites" 1]{
In my opinion, there shouldn't be any things you should know before diving right into an introductory project like that, but sadly, there are.

If you're going for ◊li-mark{1.}, it might be a good idea to read chapters 2.-10. of ◊link["https://tldp.org/HOWTO/Unix-and-Internet-Fundamentals-HOWTO/"]{Unix and Internet Fundamentals}. Otherwise (◊li-mark{2.}), go find yourself some walkthrough online ;)

◊hint[#:type "warning"]{
	Either way:
	
	◊e{Make sure you make the VM very small (about 4 Gb) or install it into the ◊c{~/goinfre}-folder.}

	If you don't, your system easily runs out of available memory, and you probably don't want that.
}
}

◊sec["During" 1]{
	◊quote-block[#:author "Leslie Lamport"]{If you're thinking without writing, you only think you're thinking.}

	How much you learn here depends almost completely on you. As the subject doesn't really provide the time for deep understanding, some tips on how to get the most out of it:
	◊ul{
		◊li{Jot down concepts you didn't know about before.}
		◊li{Link them with your concrete encounters with them. (These may be the specific commands you typed, but also the folders stuff related to them gets stored in, the files you changed accordingly, or even only the name of the tool you installed for using that concept.)}
	}
}

◊sec["Cleaning Up" 1]{
	◊ul{
		◊li{Can you access your VM via ssh?}
		◊li{Does your ◊c{monitoring.sh} work?}
		◊li{Find out what exactly a ◊e{snapshot} is, and how it differs from a ◊e{clone}}
		◊li{Create a snapshot or clone of your VM}
	}
}

◊sec["Aftercare" 1]{
	◊narr{Time for some reflection on this project, as I think this should at least be mentioned. You did some stuff, but how much of it makes some actual sense?}

	◊ol{
		◊li{Should we change our passwords regularly?}
	}

	And some answers:
	◊ol{
		◊li{Seems like no: ◊link["https://xkcd.com/936/"]{An xkcd} for your general intuition – but also ◊link["https://pages.nist.gov/800-63-FAQ/#q-b05"]{more} ◊link["https://www.sans.org/blog/the-debate-around-password-rotation-policies/"]{serious} ◊link["https://docs.microsoft.com/en-us/microsoft-365/admin/misc/password-policy-recommendations?view=o365-worldwide"]{sources} discourage it.}
	}
}

◊sec["Pointers" 1]{
◊ul{
	◊li{◊link["https://github.com/HEADLIGHTER/Born2BeRoot-42"]{Some Walkthough}}
	◊li{◊link["https://baigal.medium.com/born2beroot-e6e26dfb50ac"]{A Walkthrough-article about it}}
}
}