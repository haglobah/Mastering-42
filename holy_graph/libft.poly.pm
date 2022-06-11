#lang pollen

◊title[#:sub "by bhagenlo"]{libft}

Your library at 42 School. Your first project.

And therefore, first things first. You're new here, things are overwhelming. That's okay.

And even more so a reason listen carefully to this advice we want to give: 
◊quote-block{
	Do not fall into the Macho trap. Not in this project, not in any other. You do not have to have come up with every idea in your code yourself. So do yourself a favor and read some other code. Learning from others is how human society works. Please do not deprive yourself of that possibility. Deal?
}

◊sec["Prerequisites" 1]{
For starting your work on the libft, you should know how to:
◊ul{
	◊li{Assign a variable}
	◊li{Write a functioning (while(!)-)loop ◊e{without having off-by-one errors}}
	◊li{Declare a function}
	◊li{Declare and use an array}
	◊li{Use a header file}
	◊li{Compile your program on the command line}
	◊li{(somehow) properly work with pointers}
}
}

◊sec["During" 1]{
While working on your libft, you'll (need) get to know:
◊ul{
	◊li{How to write a Makefile}
	◊li{Function pointers and how they work}
	◊li{Allocating memory, meaning:}
	◊ul{
		◊li{Mallocing ◊e{the right amount of memory}, with the right cast}
		◊li{Protecting your ◊code{malloc()}}
		◊li{Freeing your memory afterwards, using ◊code{free()}}
	}
}

Some Tasks where it makes even more sense than normally to think ◊e{before} you start with coding:
◊ul{
	◊li{◊code{ft_memmove()} – how can you move the content without loss, ◊e{even when the locations overlap}? (◊e{and} without copying the content?)}
	◊li{◊code{ft_strlcpy()} – are you really sure you know what the man page wants you to do?}
	◊li{◊code{ft_strlcat()} – are you really sure you know what the man page wants you to do?}
	◊li{◊code{ft_split()} – this function is just very, very hard (compared to the others). Acknowledge that, and take your time ;)}
	◊li{◊code{ft_strmapi()} / ◊code{ft_striteri()} – well, make sure you know how to use function pointers ;)}
} 
}

◊sec["Cleaning Up" 1]{
Not so much here, as the subject matter is comparatively clear about the task at hand. However:

◊ul{
	◊li{What value does you ◊code{ft_strlcat()} return? And how many bytes does it append? Is it always ◊code{NULL}-terminating your string?}
	◊li{What happens when a ◊code{malloc} inside your ◊code{ft_split} fails? Are you freeing all of previously allocated splits?}
}
}

◊sec["Aftercare" 1]{
Are your evals over and Moulinette let you through? Congrats! :)

Let's make sure you memorize stuff you'll need for the future. Some tasks for you:

(The modus here is called ◊e{practice testing} – meaning: take some time, don't use help, but just try very hard to retrieve the information. Please check your mistaked immediately afterwards.)
◊ul{
	◊li{Write the Makefile for your libft from Scratch. The filenames are completely unimportant, rather try to get the overall structure right.}
	◊li{Write the Header for the libft from Scratch. Same again: The function names are not that important (ever though it is nice if you remember them ;)). Try to get the overall structure right.}
	◊li{Include some other (arguably even more useful) functions into your libft. An (incomplete) list of ideas:}
	◊ul{
		◊li{◊code{ft_strcmp(char *s1, char *s2)}}
		◊li{◊code{ft_c_isin_str(char c, char *str)} – yes, you can also just use ◊code{ft_strchr} for that in a hacky way.}
		◊li{◊c{ft_str_isin_strs(char *needle, char **needle-box)}}
	}
}
And because I don't want to be mean – here is the header code ;)

◊code-block['c]{
int	ft_strcmp(char *s1, char *s2);
int	ft_c_isin_str(char c, char *str);
int	ft_str_isin_strs(char *needle, char **box_of_needles);
}

With that, you should be good to go. See you :)
}