#lang pollen

◊title[#:sub "by skienzle"]{ft_containers}


◊narr{
	Welcome reader!
	I'm sure yo've already heard your fair share of rant about this project, so it's finally time for you to start ranting aswell

	On a more serious note: As of now this is the biggest solo project in the core, so things might take a little longer than usual and that's okay :)
}


◊sec["Prerequesites" 1]{
Before starting your work you should know:
◊ul{
	◊li{How to write a templated class and (member) function}
	◊li{What the compiler does in the background when compiling your template
	◊e{This might seem trivial at first but will come in handy later}}
	◊li{Why template implementations can't be inside .cpp files}
	◊li{The methods and basic internal structure of the containers you have to rewrite}
	◊li{How to ◊e{properly} use the ◊code{std::allocator}}
}


◊quote-block{
If debugging is the process of removing bugs, then programming must be the process of putting them in.
	(Edsger Dijkstra)
}


◊narr{
I'm not putting this in here for no reason. Because the subject requres us to write our own tests I recommend you to do so after every method you complete. I didn't. And I regretted it.
}

} ◊; sec["Prerequesites" 1]


◊sec["During" 1]{


If your are not sure how to implement something don't be afraid to open the ◊code{std} implementation of the containers and look at the relevant snippets. Depending on your platform and toolchain they might be quite hard to read (I'm looking at you LLVM), but it's a good exercise to improve in reading large-scale projects


Before starting to implement any method make sure to take a look at:
◊ul{
	◊li{The standart this method appeared in. You will only have to rewrite it if it's C++98}
	◊li{Its time complexity, iterator validity and exception safety}
}


◊(hline)


Here are some important topics you will learn about during the project:
◊ul{
	◊li{The pros and cons of different containers (data structures)}
	◊li{How BSTs and especially self-balancing BSTs work}
	◊li{How iterators work and why they are ubiquitous in most languages}
	◊li{debugging templates}
	◊li{Why ◊link["cs_theory/languages/C++/iterator_traits"]{iterator_traits} exist and how to use them}
	◊li{◊irr{What ◊link["/cs_theory/languages/C++/SFINAE"]{SFINAE} is and how to use ◊code{enable_if}}}
}
◊; @TODO Write guides for iterator_traits and SFINAE

} ◊; sec["During" 1]

◊sec["Cleaning up" 1]{
Before sumitting the project make sure:
◊ul{
	◊li{Only the required methods are public in your containers}
	◊li{The container inside your stack has the right name and is protected, not private or public}
	◊li{You have all the required operator overloads for your iterators}
	◊ul{
		◊li{Are you able to construct a ◊code{const} iterator from a normal one?}
		◊li{Are you able to compare an iterator with a ◊code{const} iterator and vice versa?}
	}
	◊li{You ◊b{never} compare the elements in your BST with anything but the comparison object (yes, this includes ◊b{not} comparing for equality through the ◊code{==} operator)}
	◊li{To take a look at the external ◊code{swap()} function. In some cases it's C++11 and in others not}
	◊li{
		If a method takes templated parameters, like e.g.
		◊code-block['c++]{
			template<class InputIterator>
			vector.assign(InputIterator first, InputIterator last)
		}
		to test this method with the supported ◊link["https://cplusplus.com/reference/iterator/"]{iterator categories}
	}
}

} ◊; sec["Cleaning up" 1]


◊sec["Aftercare" 1]{

You passed and haven't lost your sanity in the process? Well done!

Here are some questions 
◊ul{
	◊li{Why do some containers store items in random and others in ascending order?}
	◊li{Why are there different iterator categories?}
	◊li{Do you know the difference between the iterator categories? (especially ◊code{input_iterator} and ◊code{forward_iterator})}
	◊li{What are the pros / cons of BSTs compared to hashmaps? What time and space complexity do both have?}
}

By now you are probably quite fed up with templates and containers, so the exercise is going to be rather simple. I promise.
◊ul{
	◊li{Rewrite the ◊code{std::array} (It's far less work as it sounds at first)}
}

} ◊; sec["Aftercare" 1]

◊sec["Pointers" 1]{
◊ul{
	◊li{◊link["https://cplusplus.com/reference/"]{cplusplus.com}, especially their explanations of ◊link["https://cplusplus.com/reference/iterator/"]{iterators}}
	◊li{◊link["https://en.cppreference.com/w/cpp"]{cppreference}, especially for their explanation of ◊link["https://en.cppreference.com/w/cpp/language/sfinae"]{SFINAE}}
	◊li{All videos about vectors, maps and iterators in this ◊link["https://www.youtube.com/playlist?list=PLlrATfBNZ98dudnM48yfGUldqGD0S4FFb"]{playlist}}
	◊li{In case you want to implement the red-black-tree:}
	◊ul{
		◊li{◊link["https://www.youtube.com/watch?v=3RQtq7PDHog"]{overview}}
		◊li{◊link["https://www.youtube.com/watch?v=qA02XWRTBdw"]{insertion}}
		◊li{◊link["https://www.youtube.com/watch?v=w5cvkTXY0vQ"]{deletion}}
	}
}

} ◊; sec["Pointers" 1]