#lang pollen

◊title[#:sub "by bhagenlo" #:version "10"]{Philosophers}

◊narr{
    Welcome, welcome, to one of the more famous thought experiments/problem statements of Computer Science. Formulated by ◊l["https://en.wikipedia.org/wiki/Dining_philosophers_problem"]{Edsger Dijkstra in 1965}, it has challenged (or plagued?) students ever since.
}


In our case, the problem statement goes the following:
◊ul{
    ◊li{There are N philosophers at a round table, as well as N forks. Each fork lies in between two philosophers.}
    ◊li{Philosophers alternately eat, sleep and think, in that order.}
    ◊li{To be able to eat, philosophers have to pick up both the forks left and right to them.}
    ◊li{When they've finished eating, they have to put them down again.}
}

So far, that sounds like a project where one can come up with any ideas/algorithms for figuring out cooperation between agents, then test them against each other, and think about which one to use when.

Sadly, that is not the case. The problem statement goes on:

◊ul{
    ◊li{Philosophers don't speak with each other.}
    ◊li{Philosophers don't know whether another philosopher is about to die.}
}

And gone is the open space for creativity. In exchange for that, you learn about ◊e{threads}, ◊e{mutexes}, and how to create proper abstractions. Which, at least, is quite nice, too.

◊sec["Prerequisites" 1]{

Before even thinking about how to handle a problem as complex as the Dining Philosophers (concurrent problems always are – our brains are just not good at this by nature), it's super useful to first create working tools. And that's what we're gonna do.

To find those, we start out by finding out ◊e{what exactly} the important functions from the subject do. You'll definitely need to manage ◊e{time}, ◊e{threads} and ◊e{mutexes}. (If you don't know what the latter two are, now is the time ;))

And we start out with time:

◊h[2]{1. ◊c{gettimeofday()}}

This function returns a ◊c{timeval} struct, which looks like that:
◊code-block['c]{
    struct timeval {
        time_t      tv_sec;     /* seconds */
        suseconds_t tv_usec;    /* microseconds */
    };
}

Clearly, you don't want to work with this. We're interested in the µs that passed since the start of our simulation. So, I'd strongly advise you to create a tool (-> write a function) that returns a proper UTC timestamp (in µs) to you.

Next, threads:

◊h[2]{2. ◊c{pthread_*}}

Again, find out what the three of them (◊l["https://man7.org/linux/man-pages/man3/pthread_create.3.html"]{create}, ◊l["https://man7.org/linux/man-pages/man3/pthread_join.3.html"]{join} and ◊l["https://man7.org/linux/man-pages/man3/pthread_detach.3.html"]{detach}) do.

Create a small working examples with (N) threads in which: 
◊ul{
    ◊li{Each thread prints their ID.}
    ◊li{The main thread waits for all the others to complete.}
    ◊li{The main thread doesn't wait fo the others to complete.}
    ◊li{Completed threads return a value.}
}

And if you, for some case, found out that you'd rather use wrapper around those functions, please do so.

Finally, mutexes:

◊h[2]{3. ◊c{pthread_mutex_*}}

Well, ◊e{find out ◊l["https://linux.die.net/man/3/pthread_mutex_init"]{what} ◊l["https://linux.die.net/man/3/pthread_mutex_unlock"]{they} ◊l["https://www.geeksforgeeks.org/mutex-lock-for-linux-thread-synchronization/"]{do}}.

And again. Create some working examples, and write a wrapper when you see fit.

}

◊sec["During" 1]{

	Now, finally. You're able to start working on our algorithm. Have fun! :)

    But keep in mind that:
    ◊ul{
        ◊li{You don't produce a locked state: Neither a deadlock nor a lifelock.}
        ◊li{◊e{Philosophers aren't allowed to speak with each other.}}
    }
}

◊sec["Cleaning Up" 1]{

    There shouldn't be that much to be done here. Grab yourself the eval sheet (or a tester), and off you go :) 
}

◊sec["Aftercare" 1 #:open? #f]{

    Now that you're done, I can say it out loud:

    ◊quote-block{Almost everything you used or did in this project was bad practice.}

    If you want or need to write a concurrent program, then:
    ◊ol{
        ◊li{◊e{Don't use C}. Use languages that are ◊l["https://go.dev/"]{suited} ◊l["https://www.rust-lang.org/"]{for} ◊l["https://www.erlang.org/"]{that}.}
        ◊li{Don't even think of writing everything by hand. Use ◊e{libraries}.}
        ◊li{Don't use anything that might block (like mutexes and semaphores), except you must. Use things relying on the ◊l["https://en.wikipedia.org/wiki/Actor_model"]{Actor Model} instead.}
        ◊li{Avoid (global) mutable state as early as modeling your problem. (Hint: You rarely need it.)}
    }
}

◊sec["Pointers" 1]{


}