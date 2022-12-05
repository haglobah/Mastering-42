#lang pollen

◊title[#:sub "by htsang" #:version "1"]{ft_printf}

◊narr{Your first lego house! Why? Because the lego house looks complicated with a lot details, yet it does not feel intimidating. You don't feel the same way? Probably you have not see what the lego for building the house are. Let's forget about being a programmer, and be a builder who drafts and plans a lot before building!}

◊sec["Prerequisites" 1]{
◊ul{
  ◊li{How to use variadic functions (the functions that start with “va_”)}
  ◊li{Read the documentation carefully, is the second argument of ◊b{va_start()} REALLY the amount of the variadic arguments?}
}

◊sec-hint["Prerequiste for Bonus"]{
  You will need to use struct. Struct surely looks terrifying, but they are just arrays with named items, play around with struct more! Recap on how to use struct: When to use ◊code{struct.item} and ◊code{struct→item}?
}
}

◊sec["During" 1]{
◊ul{
  ◊li{What is the minimum size that ◊b{va_arg} can take in its second parameter?}
  ◊li{◊b{write()} can also fail, did you catch it? If you are using your Libft functions that use ◊b{write()}, did they return the return value of ◊b{write()}?}
  ◊li{If you decided to use malloc, the chance is you might be able to achieve the same result by saving a pointer on the input string without malloc.}
  ◊li{You do not need to do buffer management. What’s that? Try calling ◊b{write()} and the original printf() in the same program and observing their printing order.}
}

◊sec-hint["During Bonus"]{
◊b{Bonus is about handling a combinations of conditions.} In the mandatory part, you have 9 formats to handle, you could handle it easily with one layer of if-else statement. In Bonus, you have to handle an extra layer of condition: ◊i{flags}.
◊ul{
  ◊li{
    Make notes on what you are supposed to print in different combinations of flags and format! Do not start writing any code until you know what are you expected to do!
    ◊ul{
      ◊li{Is there some flags that have ◊b{precedent over} another flag?}
      ◊li{Some flags only work with a certain format, which some flags work with all flags. Can you figure them out? Why do 42 split the bonus into two parts like that?}
      ◊li{What is the meaning of width and precision when they are used with the string formats (cs%) and number formats (diuxXp) respectively?}
    }
  }
  ◊li{Multiple combinations of conditions also implies that there are multiple states you want to keep track of. So naturally it is a good idea to use struct to store your states.}
  ◊li{
    ◊b{Building a house needs planning, why not in coding? Plan ahead!} Try structuring your code into two parts:
    ◊ol{
      ◊li{getting the states you need for printing in the correct format.}
      ◊li{print using the states that you gather earlier.}
    }
  }
  ◊li{What are some common operations that you know you would use? If you think of a combinations of conditions like a big tree of if-else statements, you are very likely to find common operations in different branch. Put each common operation into a function!}
}
}
}

◊sec["Cleaning Up" 1]{
◊narr{It is all good and straightforward, except for the last few technical details:}
◊ul{
  ◊li{Make sure libftprintf.a is not included in your git repository. Check by running ◊code{git ls-files}.}
  ◊li{You might have written a lot of helper functions if you realized that some of them were only used in a single file, make them static and remove them from your header file.}
}

◊sec-hint["Cleaning up Bonus"]{
  ◊narr{Well I lost words, given how hardworking you have been. But to make sure you passed your bonus, there are few checks I want you to make:}
  ◊ul{
    ◊li{% is also considered one of the formats, so flags also work with %. e.g. ◊code{ft_printf(“%5%”)} prints 4 spaces and then a percent sign.}
    ◊li{Check if “%#X” gives print a uppercase 0X instead of a lowercase 0x.}
    ◊li{f you end up with a lot of files, write your Makefile carefully to make sure the files do not relink. E.g. If you have defined some helper functions that depends on Libft. Then you need to compile Libft first, helper functions, and the core logic functions at last. It is also a good idea to only put files that need to compile together in a folder.}
  }
}
}

◊sec["Aftercare" 1]{
◊narr{First of all, let’s forget about all the mess that you have gone through. Let’s go have a cup of tea, and when we came back, let’s reflect on some details.}
◊sec-hint["1. Explicit files dependencies"]{
  If we put every function inside a single .c file, we do not need to think about file dependencies because there is only 1 file and everything will work, and you also don’t need Makefile. However, it is tough to maintain your code, what if in the next project I need to add a floating point format to my ft_printf()? You have to find the functions inside this humongous .c file to change. So instead, you put functions in different files and can search for them easily. So, what did we learn? ◊b{Each file is meant to include a group of related functions.}

  Now you have multiple files, then the problem is about how you split your functions into different files sensibly. One thing to avoid is circular ◊code{#include}, it also happens inside header files. If ◊b{moduleA.h includes moduleB.h, and moduleB.h includes moduleA}, then ◊code{#include} will expand infinitely and so the C compiler will not compile your code.

  You can find a lot of ways to resolve it by just changing the syntax, but it might be a sign that you are unclear about which group of files you are depending on. ◊b{The easiest way is to group functions with the same dependencies under the same folder}, but keep in mind that the group should also make sense conceptually so that it will be easy for you to look for the functions you want to change inside it.

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

◊sec-hint["2. Passing values around layers of functions"]{
In ft_printf(), you are required to return how many characters have you written to STDOUT, we call that ◊i{len} in the following. The intuitive way is to have most functions return ◊i{len}, so pass the ◊i{len} value around and eventually out. But what if you need to pass around multiple states? These are some ways you can try:

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
    A very good overview of the meaning of each format, as well as the order of flags in printf
    ◊link["https://www.lix.polytechnique.fr/~liberti/public/computing/prog/c/C/FUNCTIONS/format.html"]{printf format identifiers}
  }
  ◊li{
    A detailed explaination of the combination of flags
    ◊link["https://www.academia.edu/10297206/Secrets_of_printf_"]{The secrets of printf}
  }
  ◊li{
    Very important, it is a huge memory leak problem when you use %n in reality, although this format is not mentioned in this subject, this is a thing that you should know:
    ◊link["https://ctf101.org/binary-exploitation/what-is-a-format-string-vulnerability/"]{Format String vulnerability}
  }
}
}