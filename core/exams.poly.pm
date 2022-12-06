#lang pollen

◊title[#:sub "by bhagenlo"]{Writing Exams}

◊narr{Hi!

Ready for your first (or next) exam? Excited yet? Here's what you need to know (so that you don't waste time during one.)
}

In general, (at least at 42Heilbronn), in an Exam you have to do the following:

(Don't worry, it's a explained with an overlay over the wallpaper, too – it's just that nervous people make mistakes :))

◊ol{
	◊li{Log in onto the system.
		Username: ◊c{exam}
		Password: ◊c{exam}}
	◊li{Start up a shell. Execute ◊c{kinit <intraname>}
		With that, you should be up and running}
	◊li{There, you can see the Exam shell.
	You'll mostly need the commands ◊c{grademe} and ◊c{status} which both do the obvious things.}
	◊li{Start working in the ◊c{~/rendu} folder. Before even starting to write code, ◊e{make completely sure} the folder structure is exactly right. Really.}
}

◊sec["Exam 02" 1]{
	Consist of 4 levels, each with different functions you have to code.

	The subject descriptions & solutions are ◊l["https://github.com/pasqualerossi/42-School-Exam-Rank-02"]{here}. But really, I don't think you need those.

	Just make sure you know how to:
	◊ul{
		◊li{Bitshift}
		◊li{Allocate memory}
		◊li{Write a functioning loop}
		◊li{Construct strings out of numbers, and numbers out of strings (Yep, that is the hard one.)}
	}
}

◊sec["Exam 03" 1]{
	Is either ◊c{ft_printf} or ◊c{get_next_line}. Although ◊c{get_next_line} has gotten suspiciously rare lately.

	For ◊c{ft_printf}, it's only the conversions ◊c{%s}, ◊c{%d} and ◊c{%x}.
}

◊;{

◊sec["Exam 04"]{

}

◊sec["Exam 05"]{

}

◊sec["Exam 06"]{

}

◊sec["Exam 07"]{

}

}
