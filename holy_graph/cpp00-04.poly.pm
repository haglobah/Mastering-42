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

	Ookay. Let's get to know the ◊e{Orthodox Canonical Form}, shall we?
	Inside the 'New rules' part, there is an attempt to explain what this is. I'm quite sure that this second sentence is a pure translation accident. To make that concrete and clear:

	Let's say your want to have Table Tennis-Ball objects. Then, the header file ◊c{TableTennisBall.hpp} should at least contain this:

	◊code-block['cpp #:filename "TableTennisBall.hpp"]{

		class TableTennisBall
		{
			private:

			public:
			TableTennisBall();
			TableTennisBall(TableTennisBall &other);
			TableTennisBall &operator=(TableTennisBall &other);
			~TableTennisBall();
		};
	}

	Per constructor, destructor (sometimes also abbreviated: ctor & dtor) and operator overload in the Header that is inside of a public declaration, you also need to have an implementation that goes in your  TableTennisBall.cpp. That one should at least contain this:

	◊code-block['cpp #:filename "TableTennisBall.cpp"]{

		TableTennisBall(){}
		TableTennisBall(TableTennisBall &other){}
		TableTennisBall &operator=(TableTennisBall &other){}
		~TableTennisBall(){}
	}

	On how to implement those properly, refer to [this](https://cplusplus.com/articles/y8hv0pDG/) article.

	◊e{In the CPP Exam, this form is interestingly called Copliens Form.} Why?
	I don't know. 

	Well, since this is done, back to the subject. 
	
	Read the articles they're linking:
	◊ul{
		◊li{◊l["https://www.cprogramming.com/tutorial/floating_point/understanding_floating_point.html"]{C++ Article - Understanding Floating Point Numbers - Cprogramming.com}}
		◊li{◊l["https://inst.eecs.berkeley.edu//~cs61c/sp06/handout/fixedpt.html"]{Introduction to Fixed Point Number Representation}}
	}

	The next challenge you might encounter is overloading operators. This is a little difficult at the beginning. Please ask someone for 5min of their time if you're unsure how to implement that.

	I've now regularly seen the post-increment operators done wrong. Make sure you understand what you should have been doing, what this smallest representable is, and that you did implement them correctly, too.

	Here's a test to make sure everything's working:

	◊code-block['cpp #:filename "main.cpp"]{

		using std::cout;
		using std::endl;

		int main()
		{
			Fixed a(1);

			cout << endl << "=== Mutation ===" << endl;
			cout << "a: " << a << endl;
			cout << "a--: " << a-- << endl;
			cout << "a: " << a << endl;
			cout << "++a: " << ++a << endl;
			cout << "a: " << a << endl;
			cout << "a++: " << a++ << endl;
			cout << "a: " << a << endl;
			cout << "--a: " << --a << endl;
			cout << "a: " << a << endl;
		}
	}

	(Yes, those usings are allowed.)
	You're able to figure out what the printout ◊e{should} be, aren't you?

	And now — with ◊c{ex03} comes an actually interesting exercise. 
	In case you want to do that: Read about binary space partitioning.
	You might want to start here for a general overview: ◊l["https://twobithistory.org/2019/11/06/doom-bsp.html"]{BSP: Doom}
	After you're done reading that, a small internet search will surely be able to help you.

	Try to write the code so that other people can read it. That is not trivial in this case.
}

◊sec["CPP 03" #:sub "written for version 6" 1]{

	Wohoo, you've arrived at the core of class-based object oriented programming: ◊e{Inheritance}.

	◊; But before going into that, it is quite useful to understand what an object really is. For this, refer to ◊article{The Essence of Objects}.

	So: Read up on how C++ inheritance works:
	◊ul{
		◊li{◊l["https://isocpp.org/wiki/faq/basics-of-inheritance"]{Inheritance: Basics}}
		◊li{◊l["https://isocpp.org/wiki/faq/strange-inheritance"]{Inheritance: What your mother never told you}}
	}

	After that, the keywords to search for are: ◊c{virtual}, ◊c{protected}, and ◊e{diamond of death cpp}.

	Well, I'll be supplying a little more help. Here is what Wikipedia says about multiple inheritance in C++: 
	◊hint{
		◊l["https://en.wikipedia.org/wiki/C%2B%2B"]{C++} by default follows each inheritance path separately, so a ◊c{D} object would actually contain two separate ◊c{A} objects, and uses of ◊c{A}'s members have to be properly qualified. If the inheritance from ◊c{A} to ◊c{B} and the inheritance from ◊c{A} to ◊c{C} are both marked "◊c{virtual}" (for example, ◊c{class B : virtual public A}), C++ takes special care to only create one ◊c{A} object, and uses of ◊c{A}'s members work correctly. If ◊l["https://en.wikipedia.org/wiki/Virtual_inheritance"]{virtual inheritance} and nonvirtual inheritance are mixed, there is a single virtual ◊c{A}, and a nonvirtual ◊c{A} for each nonvirtual inheritance path to ◊c{A}. C++ requires stating explicitly which parent class the feature to be used is invoked from i.e. ◊c{Worker::Human.Age}. C++ does not support explicit repeated inheritance since there would be no way to qualify which superclass to use (i.e. having a class appear more than once in a single derivation list [◊c{class Dog : public Animal, Animal}]). C++ also allows a single instance of the multiple class to be created via the virtual inheritance mechanism (i.e. ◊c{Worker::Human} and ◊c{Musician::Human} will reference the same object).
	}

	Even though it's not that easy to understand, everything what you need is in there.
	Good luck! :)
}

◊sec["CPP 04" #:sub "written for version 10" 1]{

	This module is about understanding how abstract classes work in C++.

	So, spend some time on the internet to find out:
	◊ul{
		◊li{How ◊c{virtual} member functions are different from 'normal' ones}
		◊li{What a ◊e{pure virtual} function is}
	}

	With that, there is not much more than hard work awaiting :)
}

One last bit of advice for this module: Since the exam is almost exactly ex03 of CPP04, write it as soon you can. It is worth it. 

◊narr{

	Wow. What a giant amount of typing. But well done!

	Good luck on your further journey through programming and C++.

	And may you mental models always be in touch with reality.	
}