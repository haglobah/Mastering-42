#lang pollen

◊title[#:sub "by bhagenlo" #:version "12.1"]{ft_transcendence}

◊narr{
	Welcome to the World of Software Enigneering.

	Turns out, in real life one doesn't always recreate everything, for every project, from scratch.
	For now, say goodbye to your old friends C & C++. You will be using a new programming language, libraries, and frameworks, even.

	And since this much is different, you're almost back to square 1. But not completely. 
}

Transcendence will be a very different experience from what you're used to at 42. The closest thing you experienced at 42 was your piscine.

You'll have to learn (at least) one new programming language, wrangle with your browsers VM, and get to know the gigantic complexity looming inside the JavaScript Ecosystem. As well as finding out how to tackle this in a bigger team.

Time to take stock of what you have and what you need.

◊quote-block{

	You can code, and you can read others' (imperative) code. You know C-based syntaxes.
	You can search for specific information. You know that when you bang your head against a problem long enough, you'll be the one still standing.
}

This is what you needed throughout the Core. However, as I said, transcendence is different:

◊ol{
	◊li{You need to learn (at least) one whole new programming language.}
	◊li{You have work in a bigger team.}
	◊li{The problem space (a.k.a the number of possible problems to tackle) is waay larger that in every other project so far. ◊e{Choosing} which battle to pick up will be way more important than being good at slamming your head against a particular problem.}
	◊li{You'll (probably) be working across different parts of the codebase, in different programming languages, and with different frameworks and technologies.
	Good communication will become much more important compared to how it used to be.}
	◊li{You have (at least) an order of magnitude more things you don't know about.}
	◊li{You can always, and very easily, add more features ('cause everything is so loosely specified) instead of testing your existing ones properly.}
}

What a list. My advice is the following: Since you (probably) cannot oversee what you have to do for the project, it is quite unlikely that you can have a good plan for working on transcendence right now. But you need one. How can you change this?

You can change this by first learning more.

My advice is to do a pre-transcendence piscine.

So. Take yourself, as a team, two weeks (or whatever you find suitable - I took four, and wouldn't go lower than one week.).

In this time, you might want to do the following:

◊il{
	◊li{For ◊li-mark{1.}, it's kinda obvious, isn't it? You split yourself up, and then do a piscine in TypeScript, (your backend framework), SQL, HTML & CSS and your frontend framework. Easy, isn't it?}
	◊li{Why is ◊li-mark{2.} even a problem? Shouldn't more people 'just' mean 'more work gets done'? To understand why this isn't necessarily the case, read Fred Brooks' essay ◊e{The Mythical Man-Month} or have a look ◊l["https://youtu.be/vuScajG_FuI?t=623"]{here} for a good summary.}
	◊li{(◊li-mark{3.}) is the case in just about every real-world project.
	Find out how other people are doing it.
	
	Get to know what ◊e{agile}, ◊e{Scrum} and ◊e{Kanban}. Yes, you can google those on your own :)
	After you got familiar with the terminology, jump right in and find out whether it suits you: Set up a Kanban board, and fill your backlog. Make a draft of how you'd structure your teamwork with this new knowledge.}
	◊li{For tackling ◊li-mark{4.}, come up with ideas on how to limit the 'damage' from communication overhead, as described in ◊e{The Mythical Man-Month}.
	Can you split up the project differently to how you thought you'd do it initially?
	What communication can you do upfront that limits the amount of communication you need to do while implementing features. (Hint: ◊spoiler{Almost everything written here will have this as a welcome side effect already.})}
	◊li{For ◊li-mark{5.}, read up on ◊e{Design Thinking}. You are in a high-uncertainty environment (already since you know very little compared to the things you 'need' to know).
	
	This means that makes sense to structure everything you do based on the way you learn the most - at least at first. Why? Because otherwise, you might end up with almost-done features you have to redo completely, because you avoided checking some assumption (you did not know about) first.
	
	This can mean postponing the implementation of features that will slow down testing to the very end. It can also mean implementing/trying out the things you know the least about (those with the greatest uncertainties) first. Or it could just mean setting up everything so you have fast feedback loops as soon as possible.
	
	To the very least: Make sure that you have a working setup (◊c{docker compose}d, with database, backend, and frontend, from the very beginning.}
	◊li{Which brings me to ◊li-mark{6.}.
	
	Have a usable (especially ◊e{testable}) state of your project on ◊c{main}. Always.	
	Make branches small, and merge them fast (maybe even with a review?).
	
	This allows idle team members to test, test, and test - increasing your bug count, and bringing you closer to making sure you implement features correctly before moving on to the next.}
}

Does that sound like a lot? It is.

But do those points also sound like not doing them up front might become very costly in the long term? 

I bet they do.

So, be a nice 42 student, do your pre-transcendence piscine, and enjoy the rest of it much more.

◊narr{
	I wish you the most of fun :)
}

◊hint{

	This guide will always assume that you 'obey the rules'. That is, that when the subject asks for NestJS in the backend, and you think you know better/want use something different, it assumes that you'll stick with NestJS.

	Thankfully, 42 'allowed' us to choose much more freely, here. In contrast to all of the other projects, not checking every box in the Basics part of the evaluation sheet won't let you fail immediately, but only remove a few percent from your end result (and you can pass with 90%).

	I think this is on purpose, and makes it possible for us to choose differently when we see fit, which is very nice. In case you're wondering how I know this: This is what I did.
}

◊sec["Prerequisites" 1]{

	I hope that I could convince you of this plan. Our proposed prerequisites for this project are the outcome of the things written above. Some of them could use some more clarification, though:

	◊sec["Learning the Programming Languages" #:open? #f 2]{

		Fittingly, there are at least five different (domain specific) languages you need to use/understand for transcendence. It's definitely useful if all of you know all of these languages a little, but in case you ◊e{need} to split it up, I'd go for:
		◊ul{
			◊li{◊c{SQL}: 1 person}
			◊li{◊c{TS & NestJS}: 2 people}
			◊li{◊c{HTML, CSS, frontend}: 2 people}
		}
		Yes, hopefully the SQL person will be able to switch after some time.

		◊heading[3]{TypeScript}

		For TypeScript, the most important thing to understand is to understand ◊e{what it is}. So, what is it?

		TypeScript is JavaScript with way less random 'surprises'. It is JavaScript, but enhanced in a way that lets you build bigger applications more easily.

		The enhancement that makes this posssible is TypeScripts ◊e{Gradual Type System}.

		But enough of this. You don't need to become a TypeScript expert, you just have to be able to read and write little snippets.
		For this, you need to understand a few features of it first:

		◊ol{
			◊li{Open up the ◊l["https://www.typescriptlang.org/play"]{TypeScript Playground}}
			◊li{◊e{Anonymous Functions} a.k.a ◊e{lambdas}
				◊ul{
					◊li{JS/TS has two ways to create a function:
					
						◊code-block['js #:filename "example.js"]{

							function inc(a) {
								return (a + 1)
							}

							var inc2 = ((a) => {
								return (a + 1)
							})
						}
					}
					◊li{Pick a few simple functions you can come up with, and implement them in both ways.}
				}
			}
			◊li{Higher order functions: JS/TS have so-called ◊e{Higher order functions}, and developers use them all the time.
				◊ul{
					◊li{Get to know the mighty three: ◊c{map}, ◊c{filter} and ◊c{reduce}.
					Implement the examples in ◊l["https://medium.com/poka-techblog/simplify-your-javascript-use-map-reduce-and-filter-bd02c593cc2d"]{this} article.}
				}
			}
			◊li{A gradual type system:
				You're almost done. Now, let a few things go wrong. Call functions with the 'wrong' arguments (a ◊c{string} instead of a ◊c{number}) and see what happens. 

				Not so good, right?

				Then, add type annotations to every function you broke. For example:

				◊code-block['ts #:filename "example.ts"]{

					function inc(a : number) : number {
						return (a + 1)
					}

					var inc2 = ((a : number) : number => {
						return (a + 1)
					})
				}

				I think that those are the major hindrances to getting started with TypeScript. If you know of more: Please let me know! :)
			}
		} 

		◊heading[3]{SQL}

		◊ol{
			◊li{Write a migration that creates a table ◊c{products} with ◊c{product_id} (index), ◊c{name}(unique) and ◊c{price}.}
			◊li{Write a query that:
				◊ul{
					◊li{... gives you one particular product by name/by id.}
					◊li{... gives you all the products for a certain price.}
					◊li{... all the products with a name in which ◊c{(pattern)} occurs.}
				}
			}
			◊li{Create a ◊c{users} table (◊c{user_id}, ◊c{name}) and a ◊c{friends} table (◊c{user_id, user_id}). Then, write a query gets you the names of the friends of a particular user. For this, you might want to get to know what a (left/right/inner/outer) ◊e{join} is.}
		}

		◊heading[3]{HTML & CSS}
		
		◊ol{
			◊li{HTML & CSS basics:
				◊ul{
					◊li{Read/Scroll through MDNs ◊l["https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics"]{HTML basics}, followed by their ◊l["https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics"]{CSS basics}.}
					◊li{Then, have a look at various websites, and try to understand what they're doing. The MDN docs are reasonably simple, imo. (Hint: ◊spoiler{Use the ◊e{Inspector}})}
				}
			}
			◊li{Understand one of the most important bits of CSS knowledge: That CSS has different rendering algorithms. For this, read on ◊l["https://www.joshwcomeau.com/css/understanding-layout-algorithms/"]{here}.}
			◊li{Learn the one layout algorithm you're gonna use most of the time: Flexbox. (-> CSS tricks' ◊l["https://css-tricks.com/snippets/css/a-guide-to-flexbox/)"]{◊e{A Guide to Flexbox}})}
		}
		

		◊heading[3]{(your frontend framework)}
		

		This is relatively straigthforward. 'Just' create simple UI elements you think you might need. For example:


		◊ol{
			◊li{Create a simple form.}
			◊li{Create a friend list.}
			◊li{Create a chat interface. (Chat list + messages in the room + write form, or something like that.)}
		}

		◊heading[3]{NestJS}

		🤷. As I did not use Nest at all, I am a little reluctant to propose something specific to it here. I think it comes down to a 'Get familiar with you backend framework', and that's it. One thing I can think of:

		◊ol{
			◊li{Get into you router, and create a different routes.}
		}
	}

	Apart from the Programming Languages part, I think I've already said enough in the beginning. 

	One last thing I want to mention again: 

	◊e{Set up you ◊c{docker compose}d infrastructure.}
}

◊sec["During" 1]{

	After this incredibly long info, there's not so much left. There are a few things that are a little nasty (e.g. getting all the chat roles right), but you definitely have some intuition of what's right there. So, not much during 'during'.

	Whenever you have idle team members, let them test ☝️
}

◊sec["Cleaning Up" 1]{

	Not much to say here, either. Well, make sure you implemented what the subject asks us to do (or deviate, and have a good reason for it).

	The eval sheet is comparatively sane. There's one surprise on it, though:

	It asks about a spectator mode for the game. The subject does not, so this one is up to you :)
}

◊sec["Aftercare" 1]{

	Aftercare? For transcendence?

	First, give each other a pat on your shoulders. Well done.

	Since you're now going out into the grand world: How about we employ some good open source practices for the end?

	Let's write some good documentation. If you don't already have one, create a ◊c{README} for your transcendence, and fill it with anything useful. What should such a repo have so that people can use it efficiently?
}

And then: Enjoy your life without the black hole, and probably working as a software engineer.

◊narr{

	Wow. I'm amazed. You finished the Core Curriculum of 42.
	The end of a long journey.

	Take some time to enjoy yourself, and pat yourself on the shoulder.

	I wish you the best on you further journey. I'm a little sad to see you leave, but also quite proud of what you achieved.
	I hope this is not only a farewell, but also a goodbye.

	And may your paths always be crossed by people you enjoy working with.
}

◊sec["Pointers" 1]{

	◊ul{
		◊li{◊l[""]{}}
		◊li{◊l[""]{}}
	}
}