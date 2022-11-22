#lang pollen

◊title[#:sub "by bhagenlo" #:version "2"]{FdF}

◊narr{Hi! Are you excited yet?

Finally, a project you can show your non-coder friends & family. It is no 2D-game and no ◊l["https://en.wikipedia.org/wiki/Fractal"]{beautiful infinite self-similar structure}, but hey, it's about maps. And in 3D. (And has the coolest intro I've encountered so far.)

All joking aside, I think FdF is the most computationally interesting of the three – but I leave that up to you to decide.

Still here? 
Okay. What do you need to start?}

◊sec["Prerequisites" 1]{

Although the project on its own could be relatively straightforward, it is quite useful to first get accustomed to the environment you're operating in. (Hint: It's different than usual.)

◊ol{
	◊li{Get to know the library of your choice: the ◊c{minilibx} if you like memleaks, the ◊c{MLX42} if not. The former has quite a good ◊l["https://harm-smits.github.io/42docs/libs/minilibx"]{guide} made by hsmits, the latter a comprehensive official ◊l["https://github.com/codam-coding-college/MLX42/wiki"]{documentation}.}
	◊li{Read the documentation.}
	◊li{Really. At least until ◊l["https://github.com/codam-coding-college/MLX42/wiki/Hooks"]{◊e{here}}.}
}
}

◊sec["During" 1]{

Ready? Okay. What do we need to do?

We need to:
◊ol{
	◊li{Parse the map – and extract the (3D) points from it.}
	◊li{Project those points to 2D.}
	◊li{Draw them, as well as the lines in between.}
}

And that's already it. Along the lines, you'll discover ◊l["https://en.wikipedia.org/wiki/Isometric_projection"]{isometric projection}, as well as 'the' original ◊l["https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm"]{line drawing algorithm}.

Some minor remarks:
◊ul{
	◊li{Drawing outside the available pixels (meaning: drawing outside of the bottom of the window) results in Segfaults. Make sure to protect against that :)}
	◊li{The image in the subject ◊e{does not obey} isometric projection – do it right :)}
	◊li{It is also colored – I don't know why, but since the subject does not state it, we're quite certain you don't have to implement it.}
}
}

◊sec["Cleaning Up" 1]{

◊ul{

	◊li{Does the program ◊e{always} close in a clean way? (clicking 'x', typing ESC, closing the window otherwise?)}
	◊li{Make sure you don't have memory leaks – not from your own code, and not from wrong library handling :)}
}
}

◊sec["Aftercare" 1]{

Since you'll be doing another graphics project during the core, we don't think there is much more to say (or practice) for here. Maybe enjoy some free time, or meet some peers in the kitchen?

And with that:
}

◊narr{See you at the next project.

And may your projections never be skewed.}

◊sec["Pointers" 1]{

◊ul{
	◊li{A nice ◊l["https://github.com/VBrazhnik/FdF"]{repo} and ◊l["https://github.com/VBrazhnik/FdF/wiki"]{wiki}.}
	◊li{ The ◊l["https://harm-smits.github.io/42docs/libs/minilibx"]{minilibx} documentation.}
	◊li{ The ◊l["https://github.com/codam-coding-college/MLX42/wiki"]{MLX42} documentation.}
	◊li{If you're doing the color stuff, check ◊l["https://stackoverflow.com/questions/40629345/fill-array-dynamicly-with-gradient-color-c"]{this} out. }
}
}