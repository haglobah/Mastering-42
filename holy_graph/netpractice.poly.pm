#lang pollen

◊title[#:sub "by bhagenlo" #:version "2"]{NetPractice}

◊narr{◊e{This document is a System Administration related exercise.}

Hm. Okay. That is definitely right. But, to be more specific: 

	This project is an exercise ◊e{only} about how to set up ◊e{subnets} of Computer Networks.
	
	While not exactly being unhelpful, this does not give one a much bigger understanding of the Internet, either.
	
	Let's go for that instead, shall we?}

Let's turn this project learning-wise into the project it could (or should?) have been.

We'll try to learn about the following:

◊ol{
	◊li{The general history/ideas of the Internet}
	◊li{The ◊e{OSI Model}}
	◊li{What an ◊e{RFC} is}
	◊li{◊e{TCP/IP}}
	◊li{◊e{HTTP}}
	◊li{And, finally, how ◊e{subnetting} works.}
}

◊sec["Prerequisites" 1]{

	Okay. 

	◊il{
		◊li{
			For ◊ol-mark{1.}, watch Episode 28, 29 & 30 of ◊l["https://www.youtube.com/watch?v=3QhU9jd03a0&list=PL8dPuuaLjXtNlUrzyH5r6jN9ulIgZBpdo&index=29"]{this} (generally really good) series.
		}
		◊li{
			For ◊ol-mark{2.}, spend at least ten minutes reading through ◊l["https://en.wikipedia.org/wiki/OSI_model#Layer_architecture"]{this} section.
		}
		◊li{
			For ◊ol-mark{3.}, read ◊l["https://en.wikipedia.org/wiki/Request_for_Comments"]{this} Wikipedia article.
		}
		◊li{
			◊ol-mark{4.} & ◊ol-mark{5.} are already covered by ◊ol-mark{1.}, however, you might want to take a look at some other guides and see whether you've really understood it.
		}
		◊li{
			For completing the exercises (aka ◊ol-mark{6.}), take a look at ◊l["https://www.youtube.com/watch?v=5WfiTHiU4x8&list=PLIhvC56v63IKrRHh3gvZZBAGvsvOhwrRF"]{this} series for general understanding.
		}
	}
}

◊sec["During" 1]{

	Well, understand what each box means.

	The key terms here are ◊e{IP}, ◊e{destination} and ◊e{next hop}.

	When trying to do the exercises, I'd advise you to:

	◊ol{
		◊li{First, delete the content of every field you can write to. (Repeatedly hitting ◊e{TAB}, followed by ◊e{DEL})}
		◊li{Fill in network after network. Make their IPs simple. (◊c{1.1.1.1} is simple, ◊c{192.168.12.1} is not.)}
		◊li{Make the IP range of a network as small as possible. This means making their subnet mask big. Normally, this means setting the mask to ◊c{/30}.}
	}

	If you're doing it like that, it should be relatively easy to set up the respective nets on their own correctly. In case you're still encountering issues, it is quite probable that either: 
	◊ul{
		◊li{some of your nets overlap where they shouldn't} 
		◊li{or they are in different networks although they should be in the same.}
	}

	That being said, I encourage you to ask a peer for 5 minutes of their time to help you when you're stuck. It'll be worth it.

	In addition to that, don't hesitate to take a look at tblaases ◊l["https://github.com/tblaase/Net_Practice"]{solutions}.
}

◊sec["Cleaning Up" 1]{

	You did it, and are ready to practice for the eval?

	Well, most skills require some drill. And this one definitely does. 
	Start the project in practice mode, and practice until you've solved every level (at least) 3 times correctly. Then, you should be fast enough to do it in under 15 minutes.

	This way, you'll probably be well under 15 minutes, and might have some time left to explaing to your peer what the heck you've been doing there (in case they don't know already).

	Have fun :)
}

◊sec["Aftercare" 1]{

	This one's easy. No more networks.
	
	Watch some other episode of ◊l["https://www.youtube.com/watch?v=3QhU9jd03a0&list=PL8dPuuaLjXtNlUrzyH5r6jN9ulIgZBpdo"]{Crash Course Computer Science}. 
	Alternatively, may I interest you in reading a ◊l["https://www.rfc-editor.org/rfc/rfc3092"]{fun} RFC? Or ... a ◊l["https://www.rfc-editor.org/rfc/rfc2810"]{relevant} one?
}



◊narr{
	I hope I've fulfilled my promise, and you now not only know more about subnetting, but also about the Internet as a whole.

	See you :)

	And may your IP ranges never clash.	
}

◊sec["Pointers" 1]{

	◊ul{
		◊li{The ◊l["https://www.youtube.com/watch?v=5WfiTHiU4x8&list=PLIhvC56v63IKrRHh3gvZZBAGvsvOhwrRF"]{You suck at subnetting series}}
		◊li{tblaases ◊l["https://github.com/tblaase/Net_Practice"]{solutions}}
	}
}
