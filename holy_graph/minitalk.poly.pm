#lang pollen

◊title[#:sub "by bhagenlo" #:version "2"]{minitalk}

◊narr{Hey there!

Welcome to my favourite project so far. It is nice, clean, and short, and you spend most of your time learning about, ◊e{not} debugging some nasty piece of code with dubious pointer and memory errors in it.
I'm sure you'll like it, too :)}

◊;{sec["Prerequisites" 1]{


}}

◊sec["Pre & During" 1]{

Okay: What do you need to start?
The hard part about this project is, in my opinion, to know how to do what you have to do.

But first things first.
You have to build two seperate executables, a ◊c{server} and a ◊c{client}, which should communicate with each other. For that, the client should be able to send a message (a string) to its server.
Which brings us to the next question: How can two seperate processes interact in UNIX at all?

And the answer is: Via ◊l["http://www.cs.kent.edu/~ruttan/sysprog/lectures/signals.html"]{signals}.

You have two of them at your disposal: ◊c{SIGUSR1} and ◊c{SIGUSR2}.
With those, you have to somehow encode the information you want to send.

◊sec-hint["So, how could you encode information with only two different states?"]{

Hmm, let me think. With two states? You mean, like, ◊c{0} and ◊c{1}?
That sounds a lot like ◊spoiler{◊e{binary}} to me.}

And once you've understood that, the only thing left is:

◊sec-hint["How do you destruct and reconstruct your message on both sides?"]{

Want a hint? Via ◊spoiler{◊e{bitshifting} and ◊e{binary and} (◊c{&}) / ◊e{binary or} (◊c{|})}
}

And that you've got a good idea about ◊e{how} you can do things, you should be good to go :)
}

◊sec["Cleaning Up" 1]{

Well, not so much in here. If you've tested it, and it works, you should be fine.
(+No leaks, segfaults, only one global variable – the standard stuff.)
}

◊sec["Aftercare" 1]{

Weell – you now can send general signals to any process you know the ID of. So why only send ◊c{SIGUSR1} & ◊c{SIGUSR2}?
Send the following to your server:
(well, ◊e{shoot at} might fit better, in those cases.)
◊ul{
	◊li{A segfault: ◊c{SIGSEGV}}
	◊li{A bus error: ◊c{SIGBUS}}
	◊li{Terminate the process: ◊c{SIGTERM}}
	◊li{And, finally – kill the process ◊c{SIGKILL}}
	◊li{And if you haven't got enough fun so far: You can get a pretty comprehensive list with
	◊code-block['bash]{
	$ kill -l
	} or on your favourite ◊l["https://man7.org/linux/man-pages/man7/signal.7.html"]{manpage}.}
}
}

◊narr{That was nice, wasn't it?
See you again soon.

And may your signals ever reach their destination.}

◊sec["Pointers" 1]{

◊ul{
	◊li{◊l["http://www.cs.kent.edu/~ruttan/sysprog/lectures/signals.html"]{A nice overview}}
	◊li{The two ◊l["https://man7.org/linux/man-pages/man7/signal.7.html"]{signal} ◊l["https://man7.org/linux/man-pages/man2/signal.2.html"]{manpages}}
}
}