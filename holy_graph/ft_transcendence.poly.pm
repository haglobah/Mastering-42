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
	◊li{For ◊li-mark{1.}, it's kinda obvious, isn't it? You split yourself up, and then do a piscine in TypeScript+(your backend framework), SQL, and HTML & CSS.}
	◊li{Why is ◊li-mark{2.} even a problem. Shouldn't more people 'just' mean 'more work gets done'? To understand why this isn't necessarily the case, read Fred Brooks essay ◊e{The Mythical Man-Month} or have a look ◊l["https://youtu.be/vuScajG_FuI?t=623"]{here} for a good summary.}
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
	I wish you the most of fun.
}



◊sec["Prerequisites" 1]{


}

◊sec["During" 1]{

}

◊sec["Cleaning Up" 1]{


}

◊sec["Aftercare" 1]{


}


◊narr{

}

◊sec["Pointers" 1]{


}