#show StdLib;;

external ( = ) : 'a -> 'a -> bool = 
external ( <> ) : 'a -> 'a -> bool =
external ( < ) : 'a -> 'a -> bool = 
external ( > ) : 'a -> 'a -> bool = 
external ( <= ) : 'a -> 'a -> bool =
external ( >= ) : 'a -> 'a -> bool =

external compare : 'a -> 'a -> int =
  returns 0 if x is equal to y, a negative integer if x is less 
  than y, and a positive integer if x is greater than y

val min : 'a -> 'a -> 'a
val max : 'a -> 'a -> 'a

external ( == ) : 'a -> 'a -> bool = "%eq"
external ( != ) : 'a -> 'a -> bool = "%noteq" 

external not : bool -> bool = "%boolnot"
external ( && ) : bool -> bool -> bool = "%sequand"
external ( & ) : bool -> bool -> bool = "%sequand"
external ( || ) : bool -> bool -> bool = "%sequor"
external ( or ) : bool -> bool -> bool = "%sequor"

external ( |> ) : 'a -> ('a -> 'b) -> 'b = "%revapply"
  x |> f |> g is exactly equivalent to g (f (x))
external ( @@ ) : ('a -> 'b) -> 'a -> 'b = "%apply"
  g @@ f @@ x is exactly equivalent to g (f (x))external ( ~- ) : int -> int = "%negint"

external succ : int -> int = "%succint" 
external pred : int -> int = "%predint" 
external ( + ) : int -> int -> int = "%addint"
external ( - ) : int -> int -> int = "%subint"
external ( * ) : int -> int -> int = "%mulint"
external ( / ) : int -> int -> int = "%divint"
external ( mod ) : int -> int -> int = "%modint"
val abs : int -> int
val max_int : int
val min_int : int

external ( +. ) : float -> float -> float = "%addfloat"
external ( -. ) : float -> float -> float = "%subfloat"
external ( *. ) : float -> float -> float = "%mulfloat"
external ( /. ) : float -> float -> float = "%divfloat"
external ( ** ) : float -> float -> float = "caml_power_float" "pow"

external sqrt : float -> float = "caml_sqrt_float" "sqrt" 
external exp : float -> float = "caml_exp_float" "exp" 
external log : float -> float = "caml_log_float" "log" 
external log10 : float -> float = "caml_log10_float" "log10" 
external cos : float -> float = "caml_cos_float" "cos" 
external sin : float -> float = "caml_sin_float" "sin" 
external tan : float -> float = "caml_tan_float" "tan" 
external acos : float -> float = "caml_acos_float" "acos"
external asin : float -> float = "caml_asin_float" "asin" 
external atan : float -> float = "caml_atan_float" "atan" 
external atan2 : float -> float -> float = "caml_atan2_float" "atan2"
external hypot : float -> float -> float = "caml_hypot_float"
external cosh : float -> float = "caml_cosh_float" "cosh"
external sinh : float -> float = "caml_sinh_float" "sinh" 
external tanh : float -> float = "caml_tanh_float" "tanh" 
external acosh : float -> float = "caml_acosh_float" "caml_acosh"
external asinh : float -> float = "caml_asinh_float" "caml_asinh"
external atanh : float -> float = "caml_atanh_float" "caml_atanh"
external ceil : float -> float = "caml_ceil_float" "ceil" 
external floor : float -> float = "caml_floor_float" "floor"
external abs_float : float -> float = "%absfloat"
external copysign : float -> float -> float = "caml_copysign_float"

external modf : float -> float * float = "caml_modf_float"
external float : int -> float = "%floatofint"
external float_of_int : int -> float = "%floatofint"
external truncate : float -> int = "%intoffloat"
external int_of_float : float -> int = "%intoffloat"
val infinity : float
val neg_infinity : float
val nan : float
val max_float : float
val min_float : float

val ( ^ ) : string -> string -> string  
external int_of_char : char -> int = "%identity"
val char_of_int : int -> char

val string_of_bool : bool -> string     
val bool_of_string_opt : string -> bool option
val bool_of_string : string -> bool     
val string_of_int : int -> string       
val int_of_string_opt : string -> int option
external int_of_string : string -> int = "caml_int_of_string"
val string_of_float : float -> string   
val float_of_string_opt : string -> float option
external float_of_string : string -> float = "caml_float_of_string"

external fst : 'a * 'b -> 'a = "%field0"
external snd : 'a * 'b -> 'b = "%field1"

val ( @ ) : 'a list -> 'a list -> 'a list
       
val read_line : unit -> string
val read_int_opt : unit -> int option   
val read_int : unit -> int
val read_float_opt : unit -> float option
val read_float : unit -> float

type 'a ref = { mutable contents : 'a; }
external ref : 'a -> 'a ref = "%makemutable"
external ( ! ) : 'a ref -> 'a = "%field0"
external ( := ) : 'a ref -> 'a -> unit = "%setfield0"
external incr : int ref -> unit = "%incr"
external decr : int ref -> unit = "%decr"
