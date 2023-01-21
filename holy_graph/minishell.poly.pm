#lang pollen

◊title[#:sub "by bhagenlo" #:version "6"]{minishell}

◊narr{Wohoo, you've arrived at minishell. Well done!

Tokens, the environment and builtins await. Come in, come in :)}

You'll be creating a working and day-to-day usable shell. It will be able to execute arbitrary commands, have its own environment, write to/read from files, and so on.

◊hint[#:type "warning"]{

	I've yet to meet someone who genuinely enjoyed this project throughout. Almost everyone I've talked to is complaining about edge the possible edge cases they still have to/need to fix.

	They all start out implementing their own shell, and then end up implementing every peculiarity of ◊c{bash}. 
	◊e{Taking something as a reference} ◊b{is not the same as} ◊e{copying its behaviour to the tiniest detail}.

	I don't think that this is the point of the subject, but more importantly, it ◊e{should} not be. We're here to learn, remember? You can learn a lot from this subject. Heck, you're writing your own little programming language! But somehow, the joy this brings gets lost in all the edge case-fixing I've encountered.

	◊narr{Want to do something about this? ◊l["#Evaluating minishell"]{Read on}.}
}

For all of the following, there's one thing to keep in mind: 

◊quote-block{The bigger the project, the more it pays dividends to know understand what you want before you actually start to write code. Minishell is such a big project.}

That being said, let's go. 

◊sec["Prerequisites" 1]{

	Let us start by doing that: What exactly we're trying to do here?

	◊e{We are trying to implement our own programming language.}

	That's a big task, and can make one a little bit anxious, but it's also a big opportunity for us. People have been doing that since the early 50s. There's a big body of knowledge to learn from. Condensing that:

	You probably want to structure your minishell like that: 

	Input ◊c{-lexer->} tokens 
	tokens ◊c{-parser->} AST 
	AST ◊c{-evaluator->} evaluated AST
	evaluated AST ◊c{-executor->} output

	◊ol{
		◊li{Find out what a ◊e{lexer} is. What should it do in the case of minishell? What would be the resulting tokens?}
		◊li{Find out what a ◊e{parser} is. What could/should it do?}
		◊li{What is an AST (◊e{abstract syntax tree})? 
			What could it look like in our case? Draft programs (+ their AST) on paper.
			Can you think of an easier way than a tree? If so, make a draft of that, too.}
	}
}

◊sec["During" 1]{

	Apart from sticking to the proposed general structure, another thing that buys you a lot of time is to ◊e{write tests from the beginning}.

	Say, you start out with writing your lexer (for that, it might be helpful to stick to ◊l["https://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_03"]{◊c{bash}'s tokenization rules}). During that whole time, already think of test cases where your lexer might break. Collect them, and transfer them into tests. 
	Same for your parser (You can find the bash grammar ◊l["https://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_10"]{here}).
	As for the parser's output, in case you're not doing the bonus, the way to go might be to use a ◊e{Command Table} as shown ◊l["https://www.cs.purdue.edu/homes/grr/SystemsProgrammingBook/Book/Chapter5-WritingYourOwnShell.pdf"]{here}.

	For both of those: Beware of the Heredoc. (Look ◊l["https://linuxize.com/post/bash-heredoc/"]{HERE}.)

	If those both work, you're all set to implement the inner workings of a shell. I'll leave it at that.

	Except for those regularly occurring questions/issues:
	◊ul{
		◊li{Yes, it makes sense to ◊e{have your own environment (functions)}. How do you get it? ◊spoiler{-> ◊c{extern char **environ}.}}
		◊li{Before going on, research what every allowed function in the subject description does.}
	}
}

◊sec["Cleaning Up" 1]{

	Oof. I'm not really sure what's to clean up here. I hope you tested your shell thoroughly (probably even used it for a bit), and you found it to be generally usable.

	It does make sense to ask a peer that did minishell already for a test evaluation.

	And, since you don't know who'll evaluate you, probably also go through an Eval sheet once or twice :)
}

◊sec["Aftercare" 1]{

	I hope that during this project, you learned a lot. If I may guess, you've probably been fed up by it at least two weeks ago. It was 'almost' done, but there were somehow still bugs occurring regularly. 

	What you've experienced here is how hard/impossible it is to write general, good-working systems in C. ◊e{It was due to the language you've been using for that}.
	◊ul{
		◊li{You don't have to write languages ◊e{and especially parsers} in C anymore.}
		◊li{Please, don't write parsers by hand. Use libraries.}
	}

	So, no further work on something like this for you today. Instead, you might want to take a look on how to do it differently. You may choose:
	◊ul{
		◊li{Q: I like C. How would I write a parser in a C codebase?
			A: As far as I know, you'd use ◊l["https://en.wikipedia.org/wiki/Yacc"]{◊c{yacc}}.}
		◊li{Q: I want to have speed and complete control. Which language should I pick?
			A: How about ◊l["https://www.rust-lang.org/"]{Rust}?}
		◊li{Q: I want to have the most advanced language building technology. Where should I look?
			A: For that, take a look at the ◊e{Programming Language} Programming Language (no typo): ◊l["https://racket-lang.org/"]{Racket}.}
	}
}


◊narr{Huh, what a project. One experiences the highest highs and the lowest lows. See you at the next one. 

And may your grammars always be consistent.}

◊sec["Pointers" 1]{

	◊ul{
		◊li{◊l["https://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_03"]{◊c{bash}'s tokenization rules}}
		◊li{The ◊l["https://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_10"]{bash grammar}.}
		◊li{For the ◊l["https://www.cs.purdue.edu/homes/grr/SystemsProgrammingBook/Book/Chapter5-WritingYourOwnShell.pdf"]{Command Table}.}
		◊li{◊l["https://linuxize.com/post/bash-heredoc/"]{Heredocs}}
		◊li{Harm Smits' ◊l["https://harm-smits.github.io/42docs/projects/minishell"]{guide}.}
	}
}

◊sec["Evaluating minishell" #:open? #f 1]{

	I'd like this project to be different. More about understanding, and less about tedious replication. How can we achieve that?

	I think it all comes down to how minishell gets evaluated.

	Right now, the eval sheet is a practical joke. While the others also don't ask for looking at the code, they at least leave time for actually doing that. Minishell's doesn't. But how to make it better?

	I propose the following (/something along those lines):
	(exchange the respective paragraphs from the subject with interrogations in a similar fashion.)

	◊ul{
		◊li{◊c{echo} should print the text it's given to the screen.
			Specifically: Check whether both ◊c{echo test} and ◊c{echo -n test lala} work the intended way}
		◊li{◊c{unset} should unset variables from the environment.
			Ask the evaluatees how they did do it. What does their environment look like? How do they mutate it?
			Then, check something like that:
			◊code-block['bash]{
				$ export H=42
				$ env
				...
				H=42
				$ unset H
				$ env
				(no H anymore)
			}
			◊code-block['bash]{
				$ unset PATH
				$ ls # or any other command in PATH
				ls: command not found
			}
		}
	}

	The point here is: In contrast to the normal eval sheet, the evaluator checks for ◊e{understanding}, and then tests whether the code is working ◊e{in general}.

	They ◊e{do not} try to break the shell's (or its builtins) parser at all costs, checking for every test case they know. Neither do they check only for the specific test cases of the eval sheet, which one can easily guard against.

	◊narr{I'd love to see you join me on this.

	See you around. :)}
}