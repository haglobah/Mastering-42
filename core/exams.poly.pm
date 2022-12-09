#lang pollen

◊title[#:sub "by bhagenlo and skienzle"]{Writing Exams}

◊narr{Hi!

Ready for your first (or next) exam? Excited yet? Here's what you need to know (so that you don't waste time during one.)
}

Just like during the piscine, make sure to subscibe to ◊b{event} ◊e{and} ◊b{project} on intra.

In general, (at least at 42Heilbronn), in an Exam you have to do the following:

(Don't worry, it's all explained with an overlay over the wallpaper, too – it's just that nervous people make mistakes :))

◊ol{
	◊li{Log in onto the system.
		Username: ◊c{exam}
		Password: ◊c{exam}}
	◊li{Start up a shell. Execute ◊c{kinit <intraname>}
		With that, you should be up and running.}
	◊li{There, you can see the Exam shell.
	You'll mostly need the commands ◊c{grademe} and ◊c{status} which both do the obvious things.}
	◊li{To open VSCode open the MACOS search bar (keybord shortcut: ◊e{command + space}) and type ◊e{Visual Studio Code}.}
	◊li{Start working in the ◊c{~/rendu} folder. Before even starting to write code, ◊e{make completely sure} the folder structure is exactly right. Really.}
	◊li{Don't forget to save your work (e.g. by enabling auto save in VSCode) before testing and ◊b{always compile with the flags ◊c{-Wall -Werror -Wextra}}.}
	◊li{Lastly please remember to commit and push everything before starting ◊c{grademe} in the examshell.}

}

◊sec["Exam 02" 1]{
	Consists of 4 levels, each with different functions you have to code.

	The subject descriptions & solutions are ◊l["https://github.com/pasqualerossi/42-School-Exam-Rank-02"]{here}. But really, I don't think you need those.

	Just make sure you know how to:
	◊ul{
		◊li{Bitshift}
		◊li{Allocate memory}
		◊li{Write a functioning loop}
		◊li{Construct strings out of numbers, and numbers out of strings (Yep, that is the hard one.)}
	}
}

◊sec["Exam 03" 1]{
	Is either ◊c{ft_printf} or ◊c{get_next_line}. Although ◊c{get_next_line} has gotten suspiciously rare lately.

	For ◊c{ft_printf}, it's only the conversions ◊c{%s}, ◊c{%d} and ◊c{%x}.
}


◊sec["Exam 04" 1]{
	Is ◊b{microshell}, a dumbed down version of ◊b{minishell}.
	
	You only have to handle the ◊e{pipe} ◊c{|} and ◊e{semicolon} ◊c{;} tokens, as well as the ◊c{cd} builtin.
	Also the commands are supplied through the ◊c{argv}, so no fancy ◊c{readline()} logic is required.

	Whether you want reuse the logic you used during ◊c{minishell} or come up with something new like ◊l["https://github.com/shackbei/microshell-42"]{here} is up to you. Either way, ◊b{make sure not to leak file descriptors}.
}

◊sec["Exam 05" 1]{
	Its goal is to test your knowledge of ◊l["https://en.wikipedia.org/wiki/Object-oriented_design"]{object orientation} through the use of C++ and the structure is similar  to the last exercise of ◊b{CPP Module 04}, divided into 3 seperate levels.

	Therefore, make sure to know how to work with:
	◊ul{
		◊li{Classes, Abstract classes and Interfaces}
		◊li{virtual and pure virtual methods}
		◊li{inheritance and polymorphism}
		◊li{the C++ ◊e{Standard Template Libary}, especially the member functions of either ◊c{std::vector} or ◊c{std::map}. Starting to work on ◊b{ft_containers} before doing the exam is definitely helpful, but not required}
	}

	Also you will have to create a lot of files and write a lot of classes during the exam, so here are a few tips to save some time:
	◊ol{
		◊li{All the classes of one exercise can be reused in the next one, but might need to be modified slightly.}
		◊li{There are multiple classes that are structurally similar, so ◊e{copy & paste} + ◊e{change all occurences} will be your friend.}
		◊li{Most of the implementations can be written directly into the ◊c{.hpp} files, but don't forget to create ◊c{.cpp} files and include the ◊c{.hpp} files in them!}
		◊li{Use the ◊c{c++ -Wall -Werror -Wextra *.cpp} command in your current exercise folder to avoid typing all filenames by hand.}
	}

	Lastly, ◊b{always} mark a member function as ◊c{const} if it doesn't alter the instance of a class - even if it's not requred by the subject - and check for ◊c{NULL} when dealing with pointers. This might save you unneccessary and hard to debug ◊c{grademe} fails.
}

◊sec["Exam 06" 1]{
	Is a morphed abomination between ◊b{ft_irc}, ◊b{webserv} and ◊b{the C programming language} (yep, it's C again), where you have to implement a chat server that broadcasts messages to all connected clients.

	Before going into the exam you should know how to:
	◊ul{
		◊li{work with sockets (see below).}
		◊li{use ◊c{select} for I/O-multiplexing, as it is the only allowed option during the exam.}
		◊li{write data to a buffer using the ◊c{sprintf} function.}
		◊li{launch the ◊l["https://linux.die.net/man/1/nc"]{nc} program on a specific port, as you can test you server by using multiple instances of ◊c{nc} as clients.}
	}

	In the ◊e{subject} folder you will find a ◊c{main.c} with some functions that may (or may not) be useful for your implementation, but it will give you a heads up if you need help in working with sockets.
}

◊;{

◊sec["Exam 07"]{

}

}
