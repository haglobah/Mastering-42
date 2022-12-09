#lang pollen

◊title[#:sub "by skienzle"]{iterator_traits}

◊narr{Why does this have to be so unneccessarily difficult, C++?}


◊sec["The short answer" 1]{
	◊b{because raw pointers are also valid iterators.}
	Jup, that's really the own reason for the existance of the ◊c{iterator_traits} structures, but let's elaborate further.
}

◊hline{}

◊sec-hint[#:type "info" "Click here to see the Implementation"]{
	◊code-block['C++]{
		template<class Iter>
		struct iterator_traits
		{
			typedef typename difference_type    Iter::difference_type;
			typedef typename value_type         Iter::value_type;
			typedef typename pointer            Iter::pointer;
			typedef typename reference          Iter::reference;
			typedef typename iterator_category  Iter::iterator_category;
		};

		template<class T>
		struct iterator_traits<T*>
		{
			typedef typename difference_type    ptrdiff_t;
			typedef typename value_type         T;
			typedef typename pointer            T*;
			typedef typename reference          T&;
			typedef typename iterator_category  random_access_iterator_tag;
		};

		template<class T>
		struct iterator_traits<const T*>
		{
			typedef typename difference_type    ptrdiff_t;
			typedef typename value_type         T;
			typedef typename pointer            const T*;
			typedef typename reference          const T&;
			typedef typename iterator_category  random_access_iterator_tag;
		};
	}
	◊narr{
		Quite a mess, isn't it? ;)
	}
}

◊sec["The long answer" 1]{
	◊sec["Detour to the iterator struct" 2]{
		◊sec-hint[#:type "info" "Yet another Implementation"]{
			◊code-block['C++]{
				template<
					class Categoty,
					class Type,
					class Distance = ptrdiff_t,
					class Pointer = Type*,
					class Reference = Type&
				>
				struct iterator
				{
					typedef typename Type       value_type;
					typedef typename Distance   distance_type;
					typedef typename Pointer    pointer;
					typedef typename Reference  reference;
					typedef typename Category   iterator_category;
				};
			}
		}
		As you can see the ◊c{iterator} structure just has four ◊c{typedefs} of its template parameters.
		It serves as an ◊b{interface} for the specific implementations of iterators (e.g. the vector or reverse iterator), so they are all guranteed to have those four ◊c{typedefs}
		◊irr{Please note that (as you can see ◊l["https://www.quora.com/Why-was-std-iterator-deprecated-in-c-17?share=1"]{here}) directly inheriting from ◊c{iterator} was depricated in C++17}
	}
	◊hline{}
	The ◊c{iterator_traits} serve as a gateway between iterators and the functions inside the ◊c{algorithm} header.
	However, as you can read ◊l["https://cplusplus.com/reference/iterator/RandomAccessIterator/"]{here}, ◊b{all pointers are also considered valid random access iterators}, therfore this has to be valid code:
	◊code-block['C++]{
		int array[] = { 1, 5, 2, 4, 3 };
		std::sort(array, array + 5);
	}
	Internally the ◊c{std::sort} function might need to access the ◊c{typedefs} of the ◊e{iterators} it was supplied with, but if you might recall you can't simply extract ◊c{typedefs} from a fundamental type like a ◊e{pointer}.
	This is where ◊c{iterator_traits} come into play, by providing the four ◊c{typedefs} every ◊e{iterator} has to have.
	◊hint[#:type "info"]{See the lower two structs of the implementation. The first is used for normal and the second for ◊c{const} ◊e{pointers}}

}

◊sec["Usage example" 1]{
	
}