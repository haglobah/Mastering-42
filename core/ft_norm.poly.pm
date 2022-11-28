#lang pollen

◊title[#:sub "by bhagenlo"]{Fighting the Norm (and C)}

◊narr{If you're like me, and haven't programmed extensively in C before, you might know the struggle.

You know abstractly what to do, somehow manage to do it in C, but then, ◊c{norminette} interferes.}

This is for those who are fighting those fights, too.

The first step, of course, is to write good, modular code with well-named functions and data structures.

But often, it isn't enough.

◊h[1]{Oh no: my function's too long}

◊h[2]{Shorter loops}

◊code-block['c]{
	int	i;

	i = 0;
	while (i < 10)
	{
		dostuff(i);
		i++;
	}
}

◊code-block['c]{
	int	i;

	i = -1;
	while (++i < 10)
		dostuff(i);
}

I think this is even cleaner than the 'normal' style, as you can see at one glance whether you forgot the incrementation — and not have to look about 10 lines below.

◊h[2]{Hacking together the ternary operator}

◊code-block['c #:nums? #f]{
	a = (isneg ? -num : num)
}

becomes

◊code-block['c #:nums? #f]{
	a = num * (-2 * isneg + 1)
}

– which is totally legal.


◊h[1]{Oh no: I'm declaring too many variables}

◊h[2]{Using an array}

Well, for that — provided the arguments are of the same length – you can just use an array.

This way, 
◊code-block['c #:filename "myfun.c"]{

	void	myfun(void)
	{
		int	i;
		int	j;
		int	wordcount;
		int	charcount;
		int word_started;
		int	x;
		int y;
	}
}

becomes

◊code-block['c #:filename "myfun.c"]{

	void	myfun(void)
	{
		int vars[7];

		vars = populate_vars();
	}
}

But, in my opinion, there's a better option.

◊h[2]{Usign structs}

You can just declare a struct.

◊code-block['c #:filename "myproject.h"]{

	typedef struct s_myfun_struct
	{
		int	i;
		int	j;
		int	wordcount;
		int	charcount;
		int word_started;
		int	x;
		int y;
	}	t_mf;
}

With that, ◊c{myfun} becomes:

◊code-block['c #:filename "myfun.c"]{

	void	myfun(void)
	{
		t_mf	mf_struct;

		mf_struct = (t_mf){.i = 0, .j = 0,
						   .wordcount = 0, .charcount = 0, .word_started = 0,
						   .x = 0, .y = 0};
	}
}

Feel free to omit the member names:
◊code-block['c]{
		mf_struct = (t_mf){0, 0, 0, 0, 0, 0, 0};
}

Or, if you really want to initialize every member to zero, you can even use:
◊code-block['c]{
		mf_struct = (t_mf){};
}

◊heading[1]{Oh no: I am using too many arguments to my function}

Another case for structs.

◊code-block['c #:filename "utils.c"]{

	void	super_general_fun(int a, int b, char *s1, char *s2, bool is_valid, bool is_upper, int *n)
	{
		...
	}
}

becomes

◊code-block['c #:filename "myproject.h"]{

	typedef struct s_super_general_struct
	{
		int		a;
		int		b;
		char	*s1;
		char	*s2;
		bool	is_valid;
		bool	is_upper;
		int		*n;
	}	t_sg;
}

◊code-block['c #:filename "utils.c"]{

	void	super_general_fun(t_sg s)
	{
		...
	}
}

◊sec["Pointers" 1]{

	◊ul{
		◊li{The ◊l["https://github.com/agavrel/42_CheatSheet#0x05--swindle-the-norminette---truander-la-norme"]{Swindle the norminette} section of the 42 Cheat Sheet.}
	}
}