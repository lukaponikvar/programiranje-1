val none : 'a option
none is None

some : 'a -> 'a option
some v is Some v.

get : 'a option -> 'a
get o is v if o is Some v and raise otherwise.
Raises Invalid_argument if o is None.

map : ('a -> 'b) -> 'a option -> 'b option
map f o is None if o is None and Some (f v) if o is Some v.


