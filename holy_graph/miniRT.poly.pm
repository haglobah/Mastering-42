#lang pollen

◊title[#:sub "by bhagenlo" #:version "7.1"]{miniRT}

◊narr{
	Okay. Let's take a step back for a moment. Remember what we initially said?

	◊quote-block{We said that we want to provide a map for each project.}

	What would that look like for ◊e{miniRT}? What would that look like for a ray tracer in general?

	Well, let's find out. But it's certainly gonna involve some math.
}

Ray tracing is a technique to render images. The general idea is that you have a ◊e{camera} from which you shoot ◊e{rays}, those rays hit things, and from those hitpoints you trace new rays into the lights of your scene. And depending on whether/how you hit objects along the ray◊;{(sorry, that had to be ^^)}, you display a color for this particular pixel (of your ◊e{viewport}).

◊; So, generally speaking, you'll have to to know how to handle (3d-)vectors

Sounds good? Well, let's begin!

◊sec["Prerequisites" 1]{

	◊ul{
		◊li{Write youself a ◊c{parse_double()} (and test it).}
		◊li{Find out what the ◊e{dot product} is. Calculate a few of them. Understand its geometrical interpretation (-> find out what it 'does' with two vectors in 3d space).}
		◊li{Find out what the ◊e{cross product} is. Calculate a few of them. Understand its geometrical interpretation (-> find out what it 'does' with two vectors in 3d space).}
	}

	With that, you should be able to start. 
	
	If it's been some time since you last did math, and/or you did not take any math classes at university, it might be helpful if you do those as well:
	◊ul{
		◊li{Calculate the distance of two points in 3d.}
		◊li{Calculate the hitpoint(s) of a line and a plane.}
		◊li{Calculate the hitpoint(s) of a line and a sphere.}
		◊li{Calculate the angle between two vectors. What does happen to their dot product if they are perpendicular to each other?}
	}
}

◊sec["During" 1]{

	The nice thing about those graphics projects is that you can immediately see when something went wrong. Don't waste this advantage – get youself a working output as soon as possible!

	Also, you might want to ensure to work with a freely positionable camera as early as possible.

	In addition to that:
	◊ul{
		◊li{Crazy colors? It's quite likely you're not adding/scaling you're colors correctly.}
		◊li{Interesting distortions of any kind? Check whether you've normalized all the vectors that should be.}
	}

	Ah, and please: Do youself the favor to do every calculation on the stack. It's just so much faster.
}

◊sec["Cleaning Up" 1]{

	Get yourself some example scenes, and test with them :)

	In case you're field of view is rotated in any way: That's probably just your camera. And its orientation is not specified by the subject.

	◊e{And make sure to name your executable ◊c{miniRT}}.
}

◊sec["Aftercare" 1]{

◊quote-block[#:author "Edsger Dijkstra"]{
	A programming language is a tool that has profound influence on our thinking habits.
}

	And the choice of the tool matters.
	
	If you want to become an expert programmer (in anything, really), you not only should know how to use a tool, but also when to use which one: ◊e{You should know your toolkit.}

	Up until now, if you didn't have any prior programming experience, you know only one such tool to solve the job: C. ◊irr{(+ a little bit of bash, if you want to count that.)}

	But let us, for a moment, imagine you were such an expert (that knows what other tools looked like, and now wants to evaluate how C fits into his toolkit). 
	You just completed the last project that you had to code in C. ◊e{What is C like, and when would you want to use it?}

	Feel free to use these questions for inspiration:
	◊ul{
		◊li{What do you really like about C? What don't you like?}
		◊li{For which problems is the language well-suited?}
		◊li{At which point(s) did you have the feeling the language got in your way?}
		◊li{How did it shape your thinking?}
	}

	I encourage you to write those answers down. On your journey to becoming an expert, they will change. And whenever they'll do, you then know you learned something not only about your tool, but also about your toolkit.

	Let's see what the answers look like after you create something bigger in another language. C++ awaits ;)
}

Huh. And with that: Goodbye, C, and welcome, C++.

◊narr{
	And may your mathematics always work out.
}

◊sec["Pointers" 1]{

	◊ul{
		◊li{A ◊l["https://www.scratchapixel.com/lessons/3d-basic-rendering/introduction-to-ray-tracing/how-does-it-work.html"]{tutorial + website on graphics in general}}
		◊li{Another ◊l["https://raytracing.github.io/books/RayTracingInOneWeekend.html"]{tutorial} (in C++, though).}
		◊li{Another ◊l["https://www.gabrielgambetta.com/computer-graphics-from-scratch/"]{tutorial} (very mathy)}
		◊li{◊l["https://hugi.scene.org/online/hugi24/coding%20graphics%20chris%20dragan%20raytracing%20shapes.htm"]{Intersection formulas}}


	}
}
