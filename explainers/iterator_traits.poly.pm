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
		It serves as an ◊b{interface} for the specific implementations of iterators (e.g. the ◊c{reverse_iterator}, ...), so they are all guranteed to have those four ◊c{typedefs}
		◊irr{Please note that (as you can see ◊l["https://www.quora.com/Why-was-std-iterator-deprecated-in-c-17?share=1"]{here}) directly inheriting from ◊c{iterator} was depricated in C++17}
	}
	◊hline{}
	The ◊c{iterator_traits} serve as a gateway between iterators and the functions inside the ◊c{algorithm} header.
	However, as you can read ◊l["https://cplusplus.com/reference/iterator/RandomAccessIterator/"]{here}, ◊b{all pointers are also considered valid random access iterators}, therfore this has to be valid code:
	◊code-block['C++]{
		int array[] = { 1, 5, 2, 4, 3 };
		std::sort(array, array + 5);
	}
	Internally the ◊c{std::sort} function might need to access the ◊c{typedefs} of the ◊e{iterators} it was supplied with, but if you recall you can't simply extract ◊c{typedefs} from a fundamental type like a ◊e{pointer}.
	This is where ◊c{iterator_traits} come into play, by providing the four ◊c{typedefs} every ◊e{iterator} has to have.
	◊hint[#:type "info"]{See the lower two structs of the implementation. The first is used for normal and the second for ◊c{const} ◊e{pointers}}

}

◊sec["Usage example" 1]{
	Let's take a look at how to use those ◊c{iterator_traits} in practice by re-implementing the ◊c{std::distance} function, shall we?
	◊narr{This function might also prove useful during your ◊e{ft_containers} ;)}
	After consulting the ◊l["https://cplusplus.com/reference/iterator/distance/"]{reference} we can see that there are two ways of implementing this function:
	◊ol{
		◊li{Through a call to the ◊c{operator-}, if it exists}
		◊li{Through repeated calls to the ◊c{operator++} and a counter}
	}
	Also, the function is prototyped as follows:
	◊code-block['C++]{
		template<class Iter>
		typename iterator_traits<Iter>::difference_type // <-- Return type
		distance(Iter first, Iter last);
	}
	Note that the return type already utilizes ◊c{iterator_traits} to retrive the ◊e{difference_type}.
	Alright, I'll provide you with the generic implementation and a testing ◊c{main} for our ◊c{distance} function and you add the two specializations mentioned above. Deal?

	◊sec-hint[#:type "info" "ft::distance generic implementation"]{
		◊code-block['C++]{
			#include <iterator>

			namespace ft {
			
			template<class Iter>
			typename std::iterator_traits<Iter>::difference_type
			distance(Iter first, Iter last)
			{
				return distance_impl(first, last,
				typename std::iterator_traits<Iter>::iterator_category());
			}

			} // namespace ft
		}
	}

		◊sec-hint[#:type "info" "testing main"]{
			◊code-block['C++]{
				#include <iostream>
				#include <iomanip>
				#include <vector>
				#include <array>
				#include <map>

				/* include your distance headerfile here */

				#define RED "\033[31m"
				#define GREEN "\033[32m"
				#define BLUE "\033[34m"
				#define RESET "\033[0m"

				template<class Iter>
				static void
				print_test_case(const char* test_case, Iter begin, Iter end)
				{
					std::cout << BLUE << std::setw(23) << std::left << test_case;
					if (ft::distance(begin, end) == std::distance(begin, end))
						std::cout << GREEN << "SUCCESS";
					else
						std::cout << RED << "FAIL";
					std::cout << RESET << '\n';
				}

				int main()
				{
					std::vector<int> vec{2, 5, 3, 2};
					std::array<int, 4> arr{2, 1, 6, 9};
					std::map<int,int> map{ {2, 3}, {1, 5}, {4, 7} };

					int c_arr[] = { 1, 5, 2, 3, 6 };
					const int* const_c_arr = c_arr;

					print_test_case("Test 1 - vector<int>", begin(vec), end(vec));
					print_test_case("Test 2 - array<int>", begin(arr), end(arr));
					print_test_case("Test 3 - map<int,int>", begin(map), end(map));
					print_test_case("Test 4 - int*", c_arr, c_arr + 5);
					print_test_case("Test 5 - const int*", const_c_arr, const_c_arr + 5);
				}


			}
		}

}