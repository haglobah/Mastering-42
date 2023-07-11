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

◊; ◊heading[1]{General remarks about the piscine}

◊; The subjects are good for getting to know a concept, but not so much for understanding it. Because of this, our advice for working on the subjects is the following:

◊; ◊ol{
◊; 	◊li{Do each }
◊; }

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

	Since there's no Norm in CPP anymore, I can only encourage you to write yourself a new Makefile. ◊spoiler{If you need some inspiration, you can look at the one I used: ◊l["https://github.com/haglobah/minimal-Makefile"]{https://github.com/haglobah/minimal-Makefile}.}

	Apart from that, there's not that much you need to know here:
	◊ul{
		◊li{Consult the documentation}
		◊li{Read code from others}
	}

	

}


◊sec["Pointers" 1]{


}