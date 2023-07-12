#lang pollen

◊title[#:sub "by bhagenlo" #:version "7.1"]{ft_irc}

◊narr{
	
	Wow. You've come a long way. This is your final low-level project of the Core.
	
	Time to apply all the software engineering skills you've acquired so far. Time to shine.
}

But that does not mean that this is the place to use every feature, hack, or technique you know about. Software engineering is about using the right tools & structure, not about using all of them.

So, what would make sense?
How could/should ft_irc be structured?
How should one work on such a big project in general?

Those are questions to ask yourself (as a team) beforehand.

The answers are distributed among the datastructures to use, which functionality belongs to which object, and how you want to communicate as a team. Take the time.

◊sec["Prerequisites" 1]{

	There are two areas of attack:

	◊li-mark{1.} Unix Sockets
	◊ul{
		◊li{Understand what a Unix Socket is.}
		◊li{Understand how ◊c{poll()}/◊c{select()} work.}
		◊li{Implement an ◊l["https://protohackers.com/problem/0"]{Echo Server} that can handle concurrent connections with ◊c{poll()} or ◊c{select()}. (You can open them up by using netcat (◊c{nc}), which you need to test your ◊c{ft_irc} anyway.)
		This should cost you only very little time, will clear up things, and is good practice for ◊c{mini_serv}.}
	}
	◊li-mark{2.} The IRC protocol & ecosystem 
	◊ul{
		◊li{Get familiar with the documentation of IRC. There are the RFCs (◊l["https://datatracker.ietf.org/doc/html/rfc1459"]{RFC1459}, ◊l["https://datatracker.ietf.org/doc/html/rfc2810"]{RFC2810}, ◊l["https://datatracker.ietf.org/doc/html/rfc2811"]{RFC2811}, ◊l["https://datatracker.ietf.org/doc/html/rfc2812"]{RFC2812}, ◊l["https://datatracker.ietf.org/doc/html/rfc2813"]{RFC2813}), as well as an attempt to summarize what everyone actually uses: ◊l["https://modern.ircdocs.horse/"]{modern.ircdocs.horse}}
		◊li{Try out a few IRC clients, and actually use them for a short time. This should give you some intuition on how the protocol works, really.}
		◊li{◊e{Choose your IRC client.} This may sound like it's way too early, but at least our experience they can be quite different in behaviour. So pick one, test with it from the beginning, and stick with it.}
	}
}

◊sec["During" 1]{

	◊ol{
		◊li{Did you choose your IRC client?}
		◊li{Did you implement an Echo Server?}
	}
	Well then, you're ready to go.

	The most important thing up front: ◊e{Testing is key}.
	We lost almost a week for 'just going with the protocol' when the client we chose (KVIrc) was expecting more than we thought it needed.

	So: Get to a working state (meaning: You have a server you can connect to, and that answers your requests) as soon as possible. This should be quite easy, especially since you already wrote your Echo Server, didn't you? ^^

	Then, implement a good logging infrastructure. Print out every command the server receives and sends, plus everything else that might be useful.
	
	From then on, build feature by feature incrementally, always ensuring that the new feature works, and old features don't break along the way.

	For building those, you might want to get a log (from other teams, maybe?) of what your client actually expects.

	◊; -> something about the general object-tree structure?
}

◊sec["Cleaning Up" 1]{

	There's one thing in the subject that is easy to forget until the very end: 
	◊il{
		◊li{
			The proper handling of concurrent connections with partially sent messages. Make sure your server can handle this as specified in the subject.
		}
	}
}

◊sec["Aftercare" 1]{

	And that was already it? Well done!

	And, strangely, already the last project of the Core you have to do in C++.

	How was C++? Evaluate it according to the criteria outlined ◊l["./miniRT.html#Aftercare"]{here}. After this, you probably want to start with the preparation for your ◊c{mini_serv} exam. Good luck!
}

◊narr{

	What a journey. And you came so far!
	Only one big coding project left. I wish you the best.

	And may your coworkers always write understandable code.
}

◊sec["Pointers" 1]{

	◊ul{
		◊li{◊l["https://ircgod.com/"]{An old (but still useful guide for IRC)}}
		◊li{The RFCs: ◊l["https://datatracker.ietf.org/doc/html/rfc1459"]{RFC1459}, ◊l["https://datatracker.ietf.org/doc/html/rfc2810"]{RFC2810}, ◊l["https://datatracker.ietf.org/doc/html/rfc2811"]{RFC2811}, ◊l["https://datatracker.ietf.org/doc/html/rfc2812"]{RFC2812}, ◊l["https://datatracker.ietf.org/doc/html/rfc2813"]{RFC2813}}
		◊li{◊l["https://modern.ircdocs.horse/"]{The ◊e{modern} docs}}
	}
}