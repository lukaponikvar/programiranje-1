(* 1. a) *)
let zamenjaj ((x,y), (z,w)) = ((x,z),(y,w))

(* 1. b) *)
let modus (x:int) y z = 
  match x with
  | _ when x = y -> Some y
  | _ when x = z -> Some z
  | _ when y=z -> Some y
  | _ -> None 

(* 1. c) *)
let uncons =function
  | [] -> None
  | hd :: tl -> Some (hd, tl)

(* 1. d) *)
let rec vstavljaj x = function
  | [] -> []
  | hd :: tl -> [hd; x] @ (vstavljaj x tl)

(* 1. e) *)
let popolnoma_obrni lst =
  let rec obrni acc = function
    | [] -> acc
    | x :: tl -> obrni (x :: acc) tl
in
  let rec uporabi f acc = function
    | [] -> acc
    | x :: tl -> uporabi f (f x :: acc) tl
in
  uporabi (obrni [] ) [] lst

