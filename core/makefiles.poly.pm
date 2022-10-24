#lang pollen

◊title[#:sub "by bhagenlo"]{Writing Makefiles (at 42)}

◊;narr{Some nice Intro}

◊heading[1]{Why Makefiles?}

Makefiles are there to automate the build process for us. They get used by ◊c{make} for compiling programs according to the rules in them.

The idea is that, in the end, we only have to write
◊code-block['sh #:nums? #f]{
	λ make
	...
}
instead of
◊code-block['sh #:nums? #f]{
	λ gcc a.c b.c c.c ... libft.a -o my_program
	...
}
And trust me, it is worth it – especially when there are recursive calls to other Makefiles involved.

◊hint[#:type "warning"]{
	This guide is divided into parts on purpose – only tackle the next one if you've understood (and used) the content of the one before. It is here to make your life ◊e{easier}, not harder.
	Also, view it as a buffett. Take what you like, and ignore what you don't :)
}

◊sec["0. The Base" 1]{

	Okay. What do we need for the absolute minimum?
	◊quote-block{We need the rules ◊c{$NAME}, ◊c{all}, ◊c{clean}, ◊c{fclean}, and ◊c{re}, and that it does not relink.}

	◊heading[2]{Rules}

	A ◊e{rule} consists of a ◊e{target}, ◊e{prerequisites} for that target, and commands to execute. The commands are regular commands you could execute on a shell.

	◊code-block['make]{
		<target> : <prerequisite 1> <prerequisite 2>
			<command 1>
			<command 2>
	}

	◊heading[2]{Variables}

	A ◊e{variable} consists of a ◊e{name} and a (or multiple) ◊e{value(s)}, chained together by either ◊c{=} or ◊c{:=}.
	◊ul{
		◊li{The name is written in UPPERCASE by convention.}
		◊li{The values are whitespace-separated, and consist of strings.}
	}
	◊code-block['make]{
		VARNAME = string1
		# ...
		VARNAME2 = file1.c file2.c somefolder/subfile0.c bla.c \
			foo.c bar.c
	}
	The ◊c{\} at the end is a line-separator for ◊c{make} :)

	◊heading[2]{◊c{all}}

	◊ul{
		◊li{Higly likely to be the first rule in your Makefile, as your first rule gets called implicitly when just calling ◊c{make} without parameters.}
		◊li{Consists usually only of ◊c{$(NAME)} (as a prerequisite), but also all the other startup chores you want/need to do.}
	}
	◊code-block['make]{
		NAME := libft.a
		# ...
		all : $(NAME)

	}
	◊heading[2]{◊c{$(NAME)}}

	◊ul{
		◊li{The rule where the compilation happens.}
		◊li{Since it needs the object (◊c{.o}) files, state them as prerequisites.}
		◊li{And then follows your compilation, library creation, whatever you are doing :)}
	}
	◊code-block['make]{
		SRCS := a.c
		OBJS := a.o
		# ...
		$(NAME) : $(OBJS)
			ar rcs $(NAME) $(OBJS)
		
		$(OBJS) :
			cc -Wall -Werror -Wextra -c $(SRCS)
		
	}
	◊heading[2]{◊c{clean}}

	Should clean all the object files, but not your output file(s). Therefore, pretty staightforward:
	◊code-block['make]{
		clean :
			rm -f $(OBJS)
	}
	◊heading[2]{◊c{fclean}}

	Should clean all the object files + your output file(s).
	◊code-block['make]{
		fclean : clean
			rm -f $(NAME)
	}
	◊heading[2]{◊c{re}}

	And, last but not least, ◊c{re}. It should run ◊c{fclean}, then recompile.
	◊code-block['make]{
		re : fclean
			$(MAKE) all
	}
	◊;{You might wonder why I didn't write ◊c{re : fclean all}? Well, for that reason: ◊link[""]{}}
}

◊sec["1. Helpers" 1]{

	◊h[2]{Automatic object file names}

	You probably don't want – whenever you add a new ◊c{.c} file to your ◊c{$(SRCS)} – also add the corresponding ◊c{*.o} file to your ◊c{$(OBJS)}. Neither do I.
	Here's how we fix that, without violating the 'no wildcards' rule of the Norm:

	◊code-block['make]{
		SRCS := a.c b.c c.c
		OBJS := ${SRCS:.o=.c}
	}

	◊h[2]{Automatic Variables}

	There are a few commonly used variables to make your life easier. Namely:
	◊code-block['make]{
		all : $(NAME)
			 echo $@ # Outputs the target name: "all"
			 echo $^ # Outputs the prerequisites: Content of $(NAME)
			 echo $? # Outputs all prerequisites newer than target
	}

	◊h[2]{Muting outputs}

	Normally you don't want to output all the commands you execute to ◊c{stdout} – you can mute individual commands with appending ◊c{@}:
	◊code-block['make]{
		clean :
			@rm -f $(OBJS)
			echo "ran clean."
	}

	◊h[2]{Appending to variables}

	And, if for some reason you would want to append to a variable – you might want to do that under certain conditions – just append a ◊c{+} to ◊c{=}:
	◊code-block['make]{
		CFLAGS := -Wall -Wextra

		# append if rule 'checkup' is executed
		checkup : CFLAGS += -Werror
	}
}

◊sec["2. Calling external stuff" 1]{

	◊h[2]{Recursive ◊c{$(MAKE)} calls}

	At some point in the curriculum, you'll want to use your libft, and also regularly add minor helper functions to it that might be of use not only for your current project. That means ◊e{your libft can change during a project}. Since you definitely don't want to compile it each time you changed something by hand, we'll automate that, too.
	And we're doing it by calling ◊c{make [options...]} on other Makefiles from your Makefile!

	General syntax:
	◊code-block['make]{
		$(MAKE) -C <the folder the makefile is in> <your make options>
	}

	Example:
	◊code-block['make]{
		$(MAKE) -C libft bonus
	}
	◊h[2]{Automatic library cloning}

	But that's definitely not enough. When you're able to execute ◊c{make} automatically for your libft, why don't we also clone it automatically?

	Well, I suggest that we do.
	◊code-block['make]{
	$(LIBFT) :
		if [ ! -d "libft"]; then git clone <your libft repo here>; fi
		$(MAKE) -C <the folder the makefile is in> <your make options>
	}

	◊h[2]{Using the LeakSanitizer}

	Last but not least, a tool definitely worth it to include – the ◊l["https://github.com/mhahnFr/LeakSanitizer"]{LeakSanitizer}:
	◊code-block['make]{

	lsan : $(LSAN)
	lsan : CFLAGS += -Wno-gnu-include-next -ILeakSanitizer -LLeakSanitizer -llsan -lc++
	$(LSAN) :
		if [ ! -d "LeakSanitizer"]; then git clone then git clone git@github.com:mhahnFr/LeakSanitizer.git; fi
		$(MAKE) -C LeakSanitizer
	}
}

◊sec["3. Automation" 1]{

	Well, there are a few steps common to most of the projects we use. One could argue whether they're really part of the build process, but they're definitely part of our build ◊e{pipeline} for finally delivering our software. (For more on that: Take a look at ◊l["https://en.wikipedia.org/wiki/DevOps"]{DevOps} and ◊l["https://en.wikipedia.org/wiki/CI/CD"]{CI/CD}.
	You definitely don't ◊e{need} what's in here. However, if you dislike tedious repetition as much as I do, it might be worth a look ;)

	With that, let's go:
	◊h[2]{◊c{make run}}

	Why exactly should we ◊c{make} an executable and run it in seperate steps?
	◊code-block['make]{
	run : all
		./$(NAME)
	}

	I don't know either.
	◊h[2]{◊c{make test}}

	I very much hope you're dutifully writing your tests – if you are, then why execute them by hand?
	◊code-block['make]{
	test : $(TOBJS) $(OBJS)
		$(CC) $(TOBJS) $(OBJS) -o $(TEST)
		./$(TEST)
	}

	I wouldn't like to.
	◊h[2]{◊c{make checkup}}

	When I think I'm finished, right before pushing the projects to Vogsphere for the first time, I normally:
	◊ul{
		◊li{Run all the tests}
		◊li{Check for memory leaks}
		◊li{Take a look at whether I missed something}
		◊li{Run ◊c{norminette}}
	}

	Same here:
	◊code-block['make]{
	checkup :
		echo "Testing..."
		$(MAKE) test
		echo "Checking for memory leaks..."
		$(MAKE) lsan
		echo "Did your read the subject again, and checked/asked for common mistakes?"
		norminette *.c $(NAME).h
	}

	◊h[2]{◊c{make submit}}

	And, finally: Submitting to Vogsphere. For that, we add a new ◊l["https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories"]{◊c{remote} repository} named ◊c{submit} to our repo.
	◊code-block['make]{
	submit :
	ifdef REPO
		git remote add submit $(REPO)
		git remote -v
	else
		@echo -e "You have to provide a repo. Like so:\n\n     make REPO=<the vogsphere repo> submit\n"
	endif
	}

	And with that, quite a large extent of your repetive work should have become automated.

	Happy Coding! :)
}

◊sec["Pointers" 1]{
	◊ul{
		◊li{◊link["https://www.gnu.org/software/make/manual/html_node/index.html#Top"]{The GNU make Documentation}}
		◊li{◊link["https://makefiletutorial.com/"]{A very extensive tutorial}}
	}
}
