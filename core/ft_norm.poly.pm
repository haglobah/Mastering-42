#lang pollen

◊title[#:sub "by bhagenlo"]{Fighting the Norm}

If you're like me, and haven't programmed extensively in C before, you might know the struggle.









◊h[2]{Option 1: Using ◊c{system()}}

There is already a command on our system to find memory leaks: ◊l["https://www.manpagez.com/man/1/leaks/"]{◊c{leaks}}

With that, the only thing left is to call it:

◊code-block['c]{

	#include <stdlib.h>
	...
	int main()
	{
		...
		system("leaks a.out");
		return (0);
	}
}

That will print out your leaks.

◊h[2]{Option 2: Using the LeakSanitizer}

A little more sophisticated method, as well as one you don't have to change your code for.

It has a nice & short guide on its ◊l["https://github.com/mhahnFr/LeakSanitizer"]{repo}.
I, for my part, added it to my ◊l["./makefiles.html#Using%20the%20LeakSanitizer"]{◊c{Makefile}}.

◊h[2]{Option 3: Using Valgrind}

Much more sophistication. A short guide ◊l["https://valgrind.org/docs/manual/quick-start.html"]{here}.