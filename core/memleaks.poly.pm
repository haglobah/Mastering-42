#lang pollen

◊title[#:sub "by bhagenlo"]{Finding Memory leaks}

If you don't know yet what a memory leak is, then take a look ◊l["https://letmegooglethat.com/?q=memory+leak"]{here}.

Memory leaks happen because we did not match each call to ◊c{malloc} (or ◊c{calloc}, ◊c{realloc}, ...) with a corresponding call to ◊c{free} the memory behind the pointer again. So, in theory, we could write our own 'memleak finder' ourselves – by somehow counting how many times we called ◊c{malloc} minus the times we called ◊c{free}, and we'd know whether a memory leak occured.

But fortunately, there are already tools for that.

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