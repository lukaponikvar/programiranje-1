(* 1. a) *)
let je_sodo n = (n mod 2 == 0)
(* 1. b) *)
let seznam_sodih seznam = List.filter je_sodo seznam
(* 1. c) *)
type oznaceno = 
  | Liho of int
  | Sodo of int

let oznaci seznam = 
  let rec pomozna acc = function
    | [] -> List.rev acc
    | hd :: tl -> if je_sodo hd then pomozna ((Sodo hd) :: acc) tl else pomozna ((Liho hd) :: acc) tl
  in 
  pomozna [] seznam
(* 1. d) *)

let vsoti_kvadratov =
  let rec pomozna lihi sodi = function
    | [] -> (lihi, sodi)
    | (Liho hd) :: tl -> pomozna (lihi + hd * hd) sodi tl
    | (Sodo hd) :: tl -> pomozna lihi (sodi + hd * hd) tl
  in
  pomozna 0 0 

