#lang pollen

◊title[#:sub "by bhagenlo"]{push_swap}

◊narr{Hey hey hey, you did it! You arrived at your first 'real' algorithms project.
You'll get to know layering software and unit testing, as well as the one big chunk: To learn to think in algorithms, not (only) in code.

With that, let's already get started. It's gonna be fun ;)}

◊sec["Prerequisites" 1]{

◊ol{
	◊li{
	◊sec-hint["Make sure you understand the difference between algorithm and code."]{

	As Wikipedia says, an ◊link["https://en.wikipedia.org/wiki/Algorithm"]{algorithm} is a specification of a sequence of instructions used to solve a problem or perform a computation.
	It ◊e{guarantees} correct results and it has to be clear what it does on every possible input.

	The code you'll be writing is 'just' the ◊e{implementation} of such an algorithm. This implementation can have errors, even if the algorithm is correct. However, if the algorithm has errors, then there's no way your implementation following your algorithm could ever possibly be correct.}}
	◊li{Make sure you know what ◊e{unit testing} is, and why it's highly superior to ◊e{integration/integrated testing}. (That's what you probably will do naturally ;))
	For that, you could watch the first 22 minutes of ◊link["https://www.youtube.com/watch?v=VDfX44fZoMc"]{this} talk, or read its accompanying ◊link["https://blog.thecodewhisperer.com/permalink/integrated-tests-are-a-scam"]{article}.}
	◊li{Get to know what a ◊link["https://en.wikipedia.org/wiki/Stack_(abstract_data_type)"]{stack} is.}
	◊li{Get to know some ◊link["https://en.wikipedia.org/wiki/Sorting_algorithm"]{sorting algorithms}.
	(As well as the difference between comparison and non-comparison algorithms, if you like :))}
}
}

◊sec["During" 1]{

So. You did your research? If so, let's finally start. For that, let's make a plan.

After reading the subject, you probably were a little bit confused about what exactly you would have to do to solve this task. For me, it was quite confusing at the time. That's what we'd like to provide a map for.

◊narr{(Short disclaimer: There are obviously several other approaches to this project. However, all of us who tried them did not succeed so far. See this only as a default path which work, but please feel encouraged to go on tangents whenever you like ;))}

In order to do this project, we think it's best to do the following:
◊ol{
	◊li{Create yourself some bigger struct you can put all else in, and which most of your functions take as a parameter. This might look like that:
	◊code-block['c]{
	typedef struct s_state
	{
		t_stack	*a;
		t_stack	*b;
		...
	}	t_s;
	
	typedef struct s_push_swap
	{
		t_state	*s;
		...
	}	t_ps;
	}
	
	Ah, and for the t_stack you can choose what to use. A linked list probably works a bit better than an array – but choose whatever you'd like to practice more ^^}
	◊li{Implement the basic data type. More concretely:
		◊ol{
			◊li{Implement a stack based on either a linked list or an array.}
			◊li{Implement the ◊c{push}, ◊c{pop}, ◊c{swap} and ◊c{rotate} functions on this 'stack'. (A 'real' stack has only push and pop.)
			For that, think for a moment what you'd like them to do.
				◊ul{
					◊li{What should swap and rotate on a 1-element stack do?}
					◊li{What should push with ◊c{NULL} be?}
					◊li{What should be the result of popping an empty stack?}
				}
			And only if you've come up with rules for these cases, ◊e{then} start to finally write the code.
			}
			◊li{And then, when you – after some superficial or more profound testing – have decided that your functions work, write some ◊e{unit tests}, meaning:
			Write a test that inputs some 'normal' and all the special cases and compares the behaviour of your functions with the expected one. For that, it is helpful to write this additional testing functionality inside of another file (a ◊c{test.c}, maybe?), and to add a ◊c{make test}-rule to your ◊c{Makefile} that compiles and runs the tests. That way, you can ensure that you do run the tests regularly.}
			◊li{Run ◊c{make test}:
				◊code-block['bash]{
					 $ make test
					 ...
					 Testing simple stack functions...

					 Test 4 (push): {4, 2, 3} ≠ {4, 2, 3, NULL}
					 Test 11 (rotate): {2, 2, 3, NULL} ≠ {2, 3, NULL}
					 Passed 10 / Failed 2 (of 12)
				}
				Or however you want to make it look ;)}
		}
	}
	◊li{Implement your 'special' functionality on top of your general, well-tested one.
		◊ol{
			◊li{Implement ◊c{pa}, ◊c{pb}, ◊c{sa}, ◊c{sb}, ◊c{ss}, ◊c{ra}, ◊c{rb}, ◊c{rr}, ◊c{rra}, ◊c{rrb} and ◊c{rrr}.}
			◊li{The nice thing now is: You ◊e{know for sure} that the underlying functions work. Everything that goes wrong now only can be in your small additional layer that only composes all of the underlying functions together. Plus, whenever you need to change something, you can be sure that it isn't the bottom layer (provided you tested it and didn't introduce mistakes.)}
		}
	}
	◊li{And now, finally: You've arrived at the algorithmic part. There's a few branches opening up from here, but there are two big approaches most of the people at our school took. The general idea is that you take some established algorithm (or some essential concepts out of it) and adjust it to our scenario.
	I won't guide you through an existing solution in here. But here's some general advice:
		◊quote-block{
			Think about what your algorithm should do with a set of inputs. On paper/a whiteboard/whatever. ◊e{Not} in code. Make sure you've got it in your mind, or at least written down what your sequence of steps your program should take is. And ◊e{then} try to implement it.
		}
	}
}

◊hint{
	Some promising algorithms to look at:
	◊ul{
		◊li{◊link["https://en.wikipedia.org/wiki/Heapsort"]{Heapsort}}
		◊li{◊link["https://en.wikipedia.org/wiki/Quicksort"]{Quicksort}}
		◊li{◊link["https://en.wikipedia.org/wiki/Radix_sort"]{Radix Sort}}
	}
}

And there's also a ◊link["https://github.com/o-reo/push_swap_visualizer/tags"]{push_swap visualizer} for testing your algorithmic attempts ;) (if you can't get the C++ version to run, try the python one. That should work.)
}

◊sec["Cleaning Up" 1]{

Well, not much to be done here. Make sure you tested your push_swap properly, ran it against the ◊c{checker}, and got enough points on that to pass.

That should be it. Good luck!
}

◊sec["Aftercare" 1]{

To be honest, I fear that you're already quite fed up with doing anything like push_swap again. So, no algorithms or anything in here. Instead, again some of the basics:
◊heading[2]{Task}

Implement your stack from scratch, following the same process as last time. Only this time, you choose the underlying data structure you didn't choose for push_swap. Think before you write, and also write unit tests.

◊ul{
	◊li{What is easier, what harder?}
	◊li{Would you still go with the one you've tried in the first place?}
}

And if you're like: 'Bah, I don't need that.'?

Trust us, it'll come in handy to know what an array and a linked list are good for, the latest in ◊c{minishell}.
}

◊narr{
With that, you should be good to go. See you next time :)

And may your algorithms ever be sound.
}

◊sec["Pointers" 1]{

◊ul{
	◊li{◊link["https://www.geeksforgeeks.org/sort-stack-using-temporary-stack/"]{'Sorting a stack' tutorial}}
	◊li{◊link["https://www.enjoyalgorithms.com/blog/sort-stack-using-temporary-stack"]{Another 'sorting a stack' tutorial}}
	◊li{◊link["https://github.com/anolivei/Push_swap42"]{An example project}}
	◊li{◊link["https://github.com/42YerevanProjects/42_Push_Swap"]{Another example project}}
}
}