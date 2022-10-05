#lang pollen

◊title[#:sub "by bhagenlo"]{Writing Code}

◊quote-block[#:author "Hal Abelson & Gerry Sussman"]{Programs must be written for people to read, and only incidentally for machines to execute.}

0. the way you write code so far:
1. so far, you probably wrote only monolithic programs. That is about to change.
2. the farther you progress through the curriculum, the bigger your projects are about to get, and the more complexity you will have to handle.

3. Software architecture: thinking about structure.

4. The process
   a. What problem are you trying to solve?
   b. Which pattern is suitable?
       i. Patterns: CRC, Objects, Layers
   c. Writing code top-down and bottom-up. Here, we try to reduce complexity as good as possible. Functions should be short, well-named and it should be totally transparent what they to. To support us in that, we use a technique called ◊e{wishful thinking}.

Example: Baking a cake. (Or anything else where you have some knowledge about a topic, but only little practice.)
   a. "Is this the real problem?" -> obvious.
   b. Pattern? -> CRC
   c. Okay, what does it do?
	  Ingredients ---making_the_cake---> Cake
	  making_the_cake:
		preheat_the_oven()
		mix_ingredients()
		put_into_oven()
		do_out_of_oven()
		...

Example: minishell

Example: repairing a car.

