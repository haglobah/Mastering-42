#lang pollen

◊title[#:sub "by bhagenlo"]{get_next_line}

◊narr{Hello again. Glad you're here.}

◊img["./allocating_memory.png" #:height 23]{Image originally from ◊link["https://leftoversalad.com/c/015_programmingpeople/"]{Leftover Salad}}

◊narr{True to this spirit, this project finally arrives at the heart of C Programming: Allocating memory.
It's not much code you have to write, but also not that easy to get it right. Especially when freeing.}

◊sec["Prerequisites" 1]{

So. Before starting your work at ◊c{get_next_line()}, you should know:

◊ul{
	◊li{How to assign a ◊e{static} variable (and how it works)}
	◊li{How to properly  ◊c{ft_calloc()} a pointer}
	◊li{How to properly free it}
	◊li{What a ◊link["https://en.wikipedia.org/wiki/Data_buffer"]{buffer} is}
}

}

◊sec["During" 1]{

While working on your ◊c{get_next_line()}, you'll need to get to know:

◊ul{
	◊li{◊c{read()} and how it works}
}

}

◊sec["Cleaning Up" 1]{

	Well, if your program is working – and I'm sure you tested it thoroughly, with a checker ◊e{and} for yourself, everything should be fine.
	Except for:
	◊ul{
		◊li{Did you include your ◊c{*_bonus.h} header file in your bonus files?}
	}
}

◊sec["Aftercare" 1]{
	You made it through? Nice!

	Well, there's not so much to do here:
	◊ul{
		◊li{Write a small program that actually ◊e{uses} ◊c{get_next_line()}. How about something you can pipe input into, and which then returns it line by line?
			◊code-block['bash]{
				λ echo "Hello, it's me." | ./your_echo
				Hello, it's me.
				λ
			}
		}
	}
}

◊narr{Nice, up to greater quests!

And may your memory always be freed.}

◊sec["Pointers" 1]{

	The Manpage for ◊link["https://man7.org/linux/man-pages/man2/read.2.html"]{◊c{read()}}.
}