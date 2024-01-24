length : 'a array -> int
Return the length (number of elements) of the given array.

get : 'a array -> int -> 'a
get a n returns the element number n of array a. The first element 
has number 0. The last element has number length a - 1. You can 
also write a.(n) instead of get a n.


set : 'a array -> int -> 'a -> unit
set a n x modifies array a in place, replacing element number n with x. 
You can also write a.(n) <- x instead of set a n x.


make : int -> 'a -> 'a array
make n x returns a fresh array of length n, initialized with x. b


append : 'a array -> 'a array -> 'a array
append v1 v2 returns a fresh array containing the concatenation 
of the arrays v1 and v2.

copy : 'a array -> 'a array
copy a returns a copy of a, that is, a fresh array containing the same elements as a.



to_list : 'a array -> 'a list
to_list a returns the list of all the elements of a.

of_list : 'a list -> 'a array
of_list l returns a fresh array containing the elements of l.


map : ('a -> 'b) -> 'a array -> 'b array
map f a applies function f to all the elements of a, and builds 
an array with the results returned by f: [| f a.(0); f a.(1); ...; 
f a.(length a - 1) |].

find_index : ('a -> bool) -> 'a array -> int option
find_index f a returns Some i, where i is the index of the first 
element of the array a that satisfies f x, if there is such an element.
It returns None if there is no such element.
Since 5.1


val find_map : ('a -> 'b option) -> 'a array -> 'b option
find_map f a applies f to the elements of a in order, and returns the first result of the form Some v, or None if none exist.





  split : ('a * 'b) array -> 'a array * 'b array
split [|(a1,b1); ...; (an,bn)|] is ([|a1; ...; an|], [|b1; ...; bn|]).


combine : 'a array -> 'b array -> ('a * 'b) array
combine [|a1; ...; an|] [|b1; ...; bn|] is [|(a1,b1); ...; (an,bn)|]. 
Raise Invalid_argument if the two arrays have different lengths.