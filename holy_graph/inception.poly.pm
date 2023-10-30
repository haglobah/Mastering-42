#lang pollen

◊title[#:sub "by bhagenlo" #:version "1.3"]{Inception}

◊img["../src/Images/containers_2x.png"]{

	Image originally from ◊l["https://xkcd.com/1988/"]{xkcd}
}

◊narr{

	Welcome to Inception.
}

This project is somewhat special. Its underlying idea is great. ◊e{Docker} is an incredibly useful technology, and the idea of containerization revolutionized the software world over the last decade.

However, I think that this project is were the 42 assumption to learning (being ◊e{If you do everything only from the ground up, you learn it in the best way.}) finally breaks down.

I think that for using Docker properly, one first needs to understand the larger context it exists in. Let's supply that context before we start.

◊sec["Prerequisites" 1]{

	Okay. What ◊e{is} Docker, now?

	And in which context does it exist?
	
	◊ul{
		◊li{◊l["https://www.ibm.com/topics/docker"]{What is Docker?}}
		◊li{WebAssembly seems to be somehow similar to it: ◊l["https://www.youtube.com/watch?v=-2BO43FvBuA"]{Rust, WebAssembly and the future of serverless}.}
		◊li{And then, there's also ◊l["https://nixos.org/explore.html"]{Nix}. (◊l["https://nixos.org/guides/nix-pills/why-you-should-give-it-a-try.html"]{Why Nix?})}
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
		◊li{Other tools seem to be doing similar things.}
	}

	After you've read all that, let's first ◊e{use} Docker for something, and then start Inception from there.

	In case you haven't done that before, get yourself a very simple Linux container, and test your ◊c{CPP00-04} for CPP98-conformity. 

	For example, you can try this one: ◊l["https://github.com/pauldev20/minilinux"]{https://github.com/pauldev20/minilinux}
}

◊under-construction{

	◊sec["During" 1]{

		◊ul{
			◊li{Read through carefully what the ◊c{start.sh} of minilinux does.}
			◊li{Then, try to write a ◊e{docker compose} file for minilinux.}
		}

		After you've done that, go take some time to read documentation on the various services you need to set up.

		
	}

	◊sec["Cleaning Up" 1]{

		Well, make sure it works.

		In addition to that:
		
		◊ul{
			◊li{Know how to access the Database inside the container.}
		}
	}

	◊sec["Aftercare" 1]{

		Time to actually ◊e{use} containers for something!

		Make a project of yours more accessible by automating a development setup. After Inception, I added a ◊c{docker-compose.yaml} file to the repo for this website, so that people can contribute to it way more easily.
	}

	◊narr{

		You've just made a big step towards being a professional software developer. Nice!

		And may your deployments always work reliably.
	}

	◊sec["Pointers" 1]{

		
	}
}