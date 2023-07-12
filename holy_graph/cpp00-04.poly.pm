#lang pollen

◊title[#:sub "by bhagenlo"]{CPP00-04}

◊narr{

	Hey hey :)

	Up to learning a new programming language, are we? 
}

And as it is the case with every new tool one uses, there are different tradeoffs.

You have (quite likely) mostly used C in your programming journey so far. Since this is about to change, I encourage you to do a quick review of C (as a ◊e{language in your toolkit}) as described ◊l["./miniRT.html#Aftercare"]{here}.

Did you do it?

◊spoiler{Nice.}

It's nice to be able to differentiate programming languages like this. With this foundation: How is C++ different from C?

◊hint{
	C is a small language. Programs that are written in C tend to be relatively ◊e{complex} (meaning: You have keep many things in your working memory to understand them), and relatively verbose.


	C++ is a very large language. Not only the programs that are written in it tend to be complex, one also has to potentially understand many language features to be even able to read a program.
}

This has several consequences:

◊ul{
	◊li{
		More language features are better:
		
		Many things that are verbose in C can be expressed quite concisely in C++. For example: 

		◊ul{
			◊li{You can overload operators.}
			◊li{You can write object-oriented code natively.}
			◊li{You can parameterize functions over types.}
		}
	}

	◊li{
		More language features are worse: They make your code potentially more convoluted and harder to read, understand, and reason about.
	}
}

How you resolve this tension is up to you. At every line you write.

◊quote-block{
	Use the power of C++ wisely, or it will come back to bite you.
}

◊heading[1]{General remarks about the piscine}

The subjects are good for getting to know a concept, but not so much for understanding it. Because of this, my advice for working on the subjects is the following:

◊ol{
	◊li{Read through each subject and take note of every concept/word you haven't heard about before.}
	◊li{Try to understand each of them by doing a short internet search. (Since programming languages are way more alike than they are different, you can also use resources that aren't made for C++ specifically.)}
	◊li{And only after you're sure you at least understood what the purpose/use case of each concept is, ◊e{start with coding} - and maybe reading what others did.}
}

Two last things before you start:

◊ol{
	◊li{
		Get familiar with the online documentation of C++:
		
		First, the ◊l["#TODO"]{C++ FAQ}. Then, read some example entries from ◊l["https://cppreference.com"]{cppreference.com} and ◊l["https://cplusplus.com"]{cplusplus.com}.
	}
	◊li{
		And I'm saying it again and again: But please, ◊e{read}. ◊e{others}. ◊e{code}.
	}
}

◊sec["CPP 00" #:sub "written for version 8" 1]{

	This one is mostly for getting to know CPP, so let's use it to setting things up properly.

	Since there's no Norm in CPP anymore, I can only encourage you to write yourself a new Makefile.
	
	If you need some inspiration, you can look at mine: ◊l["https://github.com/haglobah/minimal-Makefile"]{https://github.com/haglobah/minimal-Makefile}.

	Apart from that, there's not that much you need to know up front:
	◊ul{
		◊li{Consult the documentation}
		◊li{Read code from others}
	}

	◊sec["During" 2]{

		◊ul{
			◊li{I just don't know why, but your phonebook ◊e{cannot have any empty fields}. That is, you need to check that even the ◊c{darkest secret} has something filled in for every contact.}
			◊li{
				If you're just starting to learn C++ right now, and/or C++ is your second programming language, I can only encourage you not to do ◊c{ex02}. (You might want to come back later and do it then.)

				In case you're doing it, don't waste time on getting the destructor order 'right'. There's nothing you can do about it - this is even mentioned in the subject.
			}
		}
	}
}

◊sec["CPP 01" #:sub "written for version 9.2" 1]{

	Welcome to the monster module. It has a remarkable seven exercises, and the different sections are only very loosely related.

	The first two exercises are about memory allocation. You'll want to make sure that you know about the difference between the Stack and the Heap by now.

	Then, it's about pointers vs. references. Read up on their difference.

	After that, it's about being able to use ◊c{std::string} properly (and efficiently). Spend some time on the respective online documentation page, and on StackOverflow/Github :)

	For ◊c{ex05}, read the CPP FAQ on ◊l["https://isocpp.org/wiki/faq/pointers-to-members"]{Pointers to member functions}.

	And, last but not least, get to know the ◊c{switch (x) case ..: ...} construct.
}

◊sec["CPP 02" #:sub "written for version 7.1" 1]{

	
}


◊sec["Pointers" 1]{


}