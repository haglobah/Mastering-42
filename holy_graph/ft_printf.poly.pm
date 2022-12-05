#lang pollen

◊title[#:sub "by htsang" #:version "1"]{ft_printf}

◊narr{Your first lego house!
Why? Because the lego house looks complicated with a lot details, yet it does not feel intimidating. You don't feel the same way?
Probably you don't see what the pieces for building the house are.

Let's forget about you and me being a programmer for a moment. Let's tackle this project as if we were a builder who tries to build a house. Meaning: We'll draft and plan before building.}

◊sec["Prerequisites" 1]{
◊ul{
  ◊li{Understand how to create ◊e{variadic functions} with using the ◊c{va_...}-macros.}
  ◊li{Read their documentation carefully. What is the second argument of ◊c{va_start()}?}
}

◊sec["Bonus part" 2 #:open? #f]{
  You will need to use a ◊e{struct}. Structs surely look terrifying, but they are just arrays with named items. For getting to know the, play around them a little bit!

Then, for checking whether you are ready: When should you use ◊code{struct.item}, and when ◊code{struct->item}?
}
}

◊sec["During" 1]{
◊ul{
  ◊li{What is the minimum size that ◊c{va_arg} can take in its second parameter?}
  ◊li{◊c{write()} can fail – did you catch it? If you are using your Libft functions that use ◊c{write()}, did they return the return value of ◊c{write()}?}
  ◊li{If you decided to use malloc, the chance is you might be able to achieve the same result by saving a pointer on the input string without malloc.}
  ◊li{You do not need to do buffer management. What’s that? Try calling ◊c{write()} and the original printf() in the same program and observing their printing order.}
}

◊sec["Bonus part" 2 #:open? #f]{
◊b{The bonus is about handling combinations of conditions.} In the mandatory part, since you have 9 formats to handle, you could handle it easily with one layer of if-else statements. In the bonus, you have to handle an extra layer of conditions: ◊i{flags}.
◊ul{
  ◊li{
    Make notes on what you are supposed to print in different combinations of flags and format! Do not start writing any code until you know what are you expected to do!
    ◊ul{
      ◊li{Are there some flags that have ◊b{precedent over} another flag?}
      ◊li{Some flags only work with a certain format – some flags work with all flags. Can you figure them out? Why did 42 split the bonus into two parts like that?}
      ◊li{What is the meaning of width and precision when they are used with the string formats (◊c{cs%}) and number formats (◊c{diuxXp}) respectively?}
    }
  }
  ◊li{That we have multiple possivble combinations of conditions implies there are multiple states you want to keep track of. Think about how to store those. Why don't use a struct for that?}
  ◊li{
    ◊b{Building a house needs planning, why not in coding? Plan ahead!} Try structuring your code into two parts:
    ◊ol{
      ◊li{One for getting the states you need for printing in the correct format.}
      ◊li{The second for printing (using the states that you gathered earlier).}
    }
  }
  ◊li{What are some common operations that you know you would use? If you think of a combinations of conditions like a big tree of if-else statements, you are very likely to put common operations in different branches. Put each common operation into a function!}
}
}
}

◊sec["Cleaning Up" 1]{
◊narr{It is all good and straightforward, except for the last few technical details:}
◊ul{
  ◊li{Make sure libftprintf.a is not included in your git repository. You can chech that by running ◊code{git ls-files}.}
  ◊li{You might have written a lot of helper functions. If you realized that some of them were only used in a single file, make them static and remove them from your header file.}
}

◊sec["Bonus part" 2 #:open? #f]{
  ◊narr{Well I lost words, given how hardworking you have been. But to make sure you passed your bonus, there are few checks I recommend:}
  ◊ul{
    ◊li{◊c{%} is a format like everything else. That means flags should work with it, too.
	◊code{ft_printf(“%5%”)} should print 4 spaces and then a percent sign.}
    ◊li{Check if ◊c{%#X} prints a ◊c{0X} (uppercase) instead of a ◊c{0x} (lowercase).}
    ◊li{If you end up with a lot of files, make sure even more that your ◊c{Makefile} does not relink.

(Example:
You have defined some helper functions that depend on your libft.
Then you need to compile Libft first, helper functions, and the core logic functions at last. It is also a good idea to only put files that need to compile together in a folder.)}
  }
}
}

◊sec["Aftercare" 1]{
◊narr{First of all, let’s forget about all the mess that you have gone through. Let’s go have a cup of tea, and when we came back, let’s reflect on some details.}
◊sec["1. Explicit files dependencies" 2 #:open? #f]{
  If we put every function inside a single ◊c{.c} file, we do not need to think about file dependencies because there is only 1 file and everything will work, and you also don’t necessarily need a Makefile.

However, that makes it tough to maintain your code – What if in the next project you need to add a floating point format to your ◊c{ft_printf()}? You'd have to find the functions inside this humongous ◊c{.c} file you'd need to change. ◊b{Not good.}

Instead, you could put functions in different files and can search for them easily (as long as you name them properly(!)). This way, you wouldn't even have to open the file to know where you'd have to look. ◊b{Good.}

  Now you have multiple files, then the problem is about how you split your functions into different files sensibly. One thing to avoid are circular ◊code{#include}s. If ◊b{moduleA.h includes moduleB.h, and moduleB.h includes moduleA}, ◊code{#include} would expand infinitely. Thankfully, the C compiler will figure that out, and not compile your code.

  You can find a lot of ways to resolve it by just changing the your ◊c{#include}s, but it might be a sign that you are unclear about which files your file depends on. The easiest way is to ◊b{group functions with the same dependencies under the same folder}, but keep in mind that the group should also make sense conceptually so that it will be easy for you to look for the functions you want to change inside it.

  For example, the following is an excerpt of a folder structure for ft_printf. Each group of functions is stored under a folder with its corresponding header file, which conveys what dependencies that group of functions needs. And so all the functions will just include the header file from that folder.

  ◊code-block["bash"]{
  .
  |- libft/
  |---- libft.h
  |- printers/      # functions that are related to do printing
  |---- printers.h
  |- parsers/       # functions that collect information from the input string
  |---- parsers.h
  |- ft_printf.h
  |- ft_printf.c
  }

  The Makefile also makes explicit how each group of files depend on the other:

  ◊code-block["Makefile"]{
  ${MAIN_OBJS}: ${PARSERS_OBJS} ${PRINTERS_OBJS}

  ${PARSERS_OBJS}: ${LIBFT_OBJS}
  }
}

◊sec["2. Passing values around layers of functions" 2 #:open? #f]{
In ◊c{ft_printf()}, you are required to return how many characters have you written to ◊c{STDOUT}, we call that ◊c{len} in the following. The intuitive way is to have most functions return ◊c{len}, so pass the ◊c{len} value around and eventually out. But what if you need to pass around multiple states? These are some ways you can try:

◊ol{
  ◊li{
  Take in the memory address (in other words, a pointer) of a struct as an argument, and change its value inside the function.
  ◊code-block["C"]{
  void  example(t_struct *struct)
  }
  }
  ◊li{
  Use static variables inside functions. Now the variable is attached to the function, and whenever you need to read it, you can just call this function.
  ◊code-block["C"]{
  int  *example2(int input)
  {
    static int state = NULL;
    // Change the static variable depending on the input of the function
    return (&state);
  }
  }
  }
}
}
}

◊sec["Pointers" 1]{
◊ol{
  ◊li{
    A very good overview of the meaning of each format, as well as the order of flags in printf: ◊link["https://www.lix.polytechnique.fr/~liberti/public/computing/prog/c/C/FUNCTIONS/format.html"]{printf format identifiers}
  }
  ◊li{
    A detailed explaination of the combination of flags: ◊link["https://www.academia.edu/10297206/Secrets_of_printf_"]{The secrets of printf}
  }
  ◊li{
  Crazy things about printf:
  ◊ul{
    ◊li{The opition ◊c{%n}.
	TL;DR: ◊e{Don't ever use ◊c{%n} until you really understand it.}}
	◊li{You can call printf also without a format string: That produces the ◊link["https://ctf101.org/binary-exploitation/what-is-a-format-string-vulnerability/"]{format string vulnerability}.}
	}
}

}
}