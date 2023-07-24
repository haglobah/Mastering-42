#lang pollen

◊title[#:sub "by bhagenlo" #:version "1.3"]{Inception}

◊narr{

	Welcome to Inception.
}

This project is somewhat special. It's underlying idea is great. ◊e{Docker} is an incredibly useful technology, and the idea of containerization revolutionized the software world over the last decade.

However, I think that this project is were the 42 assumption to learning (being ◊e{If you do everything only from the ground up, you learn it in the best way.}) finally breaks down.

I think that for using Docker properly, one first needs to understand the larger context it exists in. Let's supply that context before we start.

◊sec["Prerequisites" 1]{

	Okay. What ◊e{is} Docker, now?
	
	◊ul{
		◊li{◊l["https://www.ibm.com/topics/docker"]{What is Docker?}}
		◊li{◊l["https://www.youtube.com/watch?v=-2BO43FvBuA"]{Rust, WebAssembly and the future of serverless}}
	}

	To sum up:
	◊ul{
		◊li{Docker is a tool to create, build and run ◊e{containers}.}
		◊li{Containers are boxes/capsules you can run your software in, and for which you can specify how they're allowed to interact with the outside world.}
		◊li{Those containers are useful in two places.
			◊ol{
				◊li{To develop software reliably (removing the 'works on my machine' problem)}
				◊li{To deploy software in an automated (and reliable way) - instead of setting up a VM by hand, you can just deploy your container image.}
			}
		}
	}

	After you've read all that, let's first ◊e{use} Docker for something, and then start Inception from there.

	In case you haven't done that before, get yourself a very simple Linux container, and test your ◊c{CPP00-04} for CPP98-conformity. 

	For example, you can try this one: ◊l["https://github.com/pauldev20/minilinux"]{https://github.com/pauldev20/minilinux}
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