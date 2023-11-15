(* variable names must start with a lowercase letter or an underscore*)

let <variable> = <expr>


let <variable> = <expr1> in <expr2>
(* This first evaluates expr1 and then evaluates expr2 
  with variable bound to whatever value was produced by 
  the evaluation of expr1. *)