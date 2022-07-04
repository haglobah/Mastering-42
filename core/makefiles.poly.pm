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

◊sec["The Base" 1]{
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
		◊li{The values are comma-separated, and consist of strings.}
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
			make all
	}
	◊;{You might wonder why I didn't write ◊c{re : fclean all}? Well, for that reason: ◊link[""]{}}
}	

◊sec["Pointers" 1]{
	◊ul{
		◊li{◊link["https://www.gnu.org/software/make/manual/html_node/index.html#Top"]{The GNU make Documentation}}
		◊li{◊link["https://makefiletutorial.com/"]{A very extensive tutorial}}
	}
}